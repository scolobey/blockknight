require "rails_helper"

describe Coin do
  it "has a valid factory" do
    FactoryGirl.create(:coin).should be_valid
  end
  it "needs a name"
  it "needs a ticker"
  it "needs a price"
end
