class NewsController < ApplicationController
  before_action :get_items, :except => [:create, :show, :update, :destroy]

  # GET /feed_items
  # GET /feed_items.json
  def index

  end

  private

    def get_items
      @news_items = FeedItem.where({approved: true}).order(:created_at).reverse_order.page params[:page]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_item_params
      params.require(:feed_item).permit(:title, :description, :image, :url, :approved, :content)
    end
end
