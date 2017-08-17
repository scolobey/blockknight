require "rails_helper"

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user, password: 'butternut').should be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "does not allow duplicate emails" do
    FactoryGirl.create(:user, email: "minedied@gmail.com", password: 'butternut')
    FactoryGirl.build(:user, email: "minedied@gmail.com", password: 'nutterbut').should_not be_valid
  end

  it "contains valid email format" do
    FactoryGirl.build(:user, email: "winkledinkle", password: 'butternut')
  end

  it "should follow and unfollow a coin" do
    dude = FactoryGirl.create(:user, email: "minedied@gmail.com", password: 'butternut')
    coin  = FactoryGirl.create(:coin)

    dude.coin_relationships.create(coin_id: coin.id).should be_valid
  end
end
