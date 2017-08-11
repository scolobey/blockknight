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
end
