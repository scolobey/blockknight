require 'rails_helper'

describe CoinRelationship do
  it "has a valid factory" do
    FactoryGirl.create(:relationship).should be_valid
  end
  it "needs a coin_id"
  it "needs a user_id"
end
