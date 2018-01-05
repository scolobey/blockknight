class CoinsController < ApplicationController
  before_action :set_coin, only: [:show, :edit, :update, :destroy]

  # GET /coins
  # GET /coins.json
  def index
    @id_set = []

    if current_user
      @favorites = current_user.coins
      @favorites.each do |item|
        @id_set.push(item.id)
      end
    end

    @coins = Coin.where(archive: nil).where.not(id: @id_set)
    # //

    get_news_items
  end

  # GET /coins/1
  # GET /coins/1.json
  def show
    @news_items = @coin.feed_items.order(created_at: :desc).first(4)
  end

  # GET /coins/new
  def new
    @coin = Coin.new
  end

  # GET /coins/1/edit
  def edit
    admin_authorize
  end

  # POST /coins
  # POST /coins.json
  def create
    @coin = Coin.new(coin_params)

    respond_to do |format|
      if @coin.save
        format.html { redirect_to @coin, notice: 'Coin was successfully created.' }
        format.json { render :show, status: :created, location: @coin }
      else
        format.html { render :new }
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coins/1
  # PATCH/PUT /coins/1.json
  def update
    respond_to do |format|
      if @coin.update(coin_params)
        format.html { redirect_to @coin, notice: 'Coin was successfully updated.' }
        format.json { render :show, status: :ok, location: @coin }
      else
        format.html { render :edit }
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coins/1
  # DELETE /coins/1.json
  def destroy
    @coin.destroy
    respond_to do |format|
      format.html { redirect_to coins_url, notice: 'Coin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def follow
    if current_user
      CoinRelationship.create(coin_id: params[:coin_id], user_id: current_user.id)
      redirect_back(fallback_location: root_path)
    else
      redirect_to '/login'
    end
  end

  def unfollow
      CoinRelationship.where({coin_id: params[:coin_id], user_id: current_user.id}).destroy_all
      redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Confusing because it's not the id, it's actually passing the name because to_param in coin.rb is overwritten.
    def set_coin
      # @coin = Coin.find_by_name!(params[:id])
      @coin = Coin.find(params[:id])
      if current_user
        @followed = @coin.followed?(current_user)
      else
        @followed = false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coin_params
      params.require(:coin).permit(:name, :ticker, :supply, :description, :team, :key_value_proposition, :twitter, :concerns, :community, :all_tags, :archive)
    end

    def get_news_items
      @news_items = FeedItem.where({approved: true}).order(:updated_at).first(5)
    end
end
