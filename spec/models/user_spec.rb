require "rails_helper"

describe User do
  it "has a valid factory" do
    FactoryBot.create(:user, password: 'butternut').should be_valid
  end

  it "is invalid without an email" do
    FactoryBot.build(:user, email: nil).should_not be_valid
  end

  it "does not allow duplicate emails" do
    FactoryBot.create(:user, email: "minedied@gmail.com", password: 'butternut')
    FactoryBot.build(:user, email: "minedied@gmail.com", password: 'nutterbut').should_not be_valid
  end

  it "contains valid email format" do
    FactoryBot.build(:user, email: "winkledinkle", password: 'butternut')
  end

  it "should follow and unfollow a coin" do
    dude = FactoryBot.create(:user, email: "minedied@gmail.com", password: 'butternut')
    coin  = FactoryBot.create(:coin)

    dude.coin_relationships.create(coin_id: coin.id).should be_valid
  end
end
