class FeedItemsController < ApplicationController
  before_action :admin_authorize
  before_action :set_feed_item, only: [:show, :edit, :update, :destroy]
  before_action :get_items, :except => [:create, :show, :update, :destroy]

  # GET /feed_items
  # GET /feed_items.json
  def index

  end

  # GET /feed_items/1
  # GET /feed_items/1.json
  def show
  end

  # GET /feed_items/new
  def new
    @feed_item = FeedItem.new
  end

  # GET /feed_items/1/edit
  def edit
  end

  # POST /feed_items
  # POST /feed_items.json
  def create
    @feed_item = FeedItem.new(feed_item_params)

    respond_to do |format|
      if @feed_item.save
        format.html { redirect_to @feed_item, notice: 'Feed item was successfully created.' }
        format.json { render :show, status: :created, location: @feed_item }
      else
        format.html { render :new }
        format.json { render json: @feed_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feed_items/1
  # PATCH/PUT /feed_items/1.json
  def update
    respond_to do |format|
      if @feed_item.update(feed_item_params)
        format.html { redirect_to @feed_item, notice: 'Feed item was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed_item }
      else
        format.html { render :edit }
        format.json { render json: @feed_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feed_items/1
  # DELETE /feed_items/1.json
  def destroy
    @feed_item.destroy
    respond_to do |format|
      format.html { redirect_to feed_items_url, notice: 'Feed item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve_checked
    @feed_items.each do |item|
      item.update_attributes({approved: false});
    end

    if params[:feed_item_ids]
      FeedItem.find(params[:feed_item_ids]).each do |item|
        item.update_attributes({approved: true});
      end
    end

    redirect_to feed_items_path

  end

  def update_news
    require 'nokogiri'
    require 'open-uri'

    # First remove news that's too old to care about.
    FeedItem.where("created_at < ?", 30.days.ago).delete_all

    Coin.where(ticker: ['BTC', 'ETH', 'LTC', 'MIOTA', 'XMR', 'GNO', 'REP', 'LSK', 'XRP', 'XLM', 'ADA', 'DASH', 'EOS', 'SC', 'GNT', 'OMG', 'ARK', 'UBQ', 'XVG', 'STORJ', 'KMD', 'BAT', 'NEO', 'TRX', 'VEN', 'ETC', 'QTUM', 'BCN', 'ZEC', 'ICX', 'ZIL', 'ONT'])
    .each do |record|

      query = "https://www.google.com/search?q=#{record.name}%20cryptocurrency&source=lnms&tbm=nws&sa=X&ved=0ahUKEwiW2ZSm5bzVAhUIzGMKHV_gAOIQ_AUICigB&biw=1371&bih=727"
      doc = Nokogiri::HTML(open(query))

      doc.css('div.g').slice(0, 10).each do |node|
        image = ''
        link = node.css('a').attr('href').text.sub(/\/url\?q=/, "").sub(/\&sa=(.*)/, "")
        title = node.css('h3.r').text.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')

        if node.at_css('img')
          image = node.css('img').attr('src')
        end

        # Use this line to blacklist certain news organizations
        if ['forbes','cnbc', 'fortune'].any? { |domain| link.to_s.include?(domain) }
          puts 'news ignored (domain):' + link.to_s
        elsif ['market cap','trading volume', 'price jump', 'dropds by', 'price prediction', 'technical analysis', 'price tops', 'price hits', 'price update', 'price reaches', 'trading up', 'trading down', 'trading close to', 'hits $', 'volume hits', 'volume reaches', 'price at', 'price up'].any? { |subject| title.downcase.include?(subject) }
          puts 'news ignored (title):' + title
        else
          news = {
            title: title,
            description: node.css('div.st').text.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''),
            image: image,
            url: link
          }

          record.feed_items.create(news)
        end

      end

    end

    redirect_to feed_items_path
  end

  private

    def get_items
      @feed_items = FeedItem.where({approved: nil}).order(:coin_id).page params[:page]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_feed_item
      @feed_item = FeedItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_item_params
      params.require(:feed_item).permit(:title, :description, :image, :url, :approved, :content)
    end
end
