require 'rails_helper'

describe 'site administrator' do
  it "accesses the dashboard" do
    User.create(
      email: 'user@example.com',
      password: 'secret',
      password_confirmation: 'secret',
      admin: true
    )

    visit root_path
    click_link 'Login'
    fill_in 'email', with: 'user@example.com'
    fill_in 'password', with: 'secret'
    click_button 'Submit'

    visit admin_path
    current_path.should eq admin_path

    page.should have_content 'Admin'
    page.should have_content 'Feed'
    page.should have_content 'Users'
  end

  it "is denied access if not authorized properly" do
    visit admin_path

    current_path.should eq login_path
  end
end
