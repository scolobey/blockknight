require 'test_helper'

class FeedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feed_item = feed_items(:one)
  end

  test "should get index" do
    get feed_items_url
    assert_response :success
  end

  test "should get new" do
    get new_feed_item_url
    assert_response :success
  end

  test "should create feed_item" do
    assert_difference('FeedItem.count') do
      post feed_items_url, params: { feed_item: { approved: @feed_item.approved, content: @feed_item.content, description: @feed_item.description, image: @feed_item.image, title: @feed_item.title } }
    end

    assert_redirected_to feed_item_url(FeedItem.last)
  end

  test "should show feed_item" do
    get feed_item_url(@feed_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_feed_item_url(@feed_item)
    assert_response :success
  end

  test "should update feed_item" do
    patch feed_item_url(@feed_item), params: { feed_item: { approved: @feed_item.approved, content: @feed_item.content, description: @feed_item.description, image: @feed_item.image, title: @feed_item.title } }
    assert_redirected_to feed_item_url(@feed_item)
  end

  test "should destroy feed_item" do
    assert_difference('FeedItem.count', -1) do
      delete feed_item_url(@feed_item)
    end

    assert_redirected_to feed_items_url
  end
end
