require "rails_helper"

describe FeedItem do
  it "has a valid factory" do
    FactoryBot.create(:feed_item).should be_valid
  end
  
  it "must have a name that doesn't include blacklist terms" do
    item = FactoryBot.build(:feed_item, title: "litecoin price predictions")
    expect(item).not_to be_valid
  end
end
