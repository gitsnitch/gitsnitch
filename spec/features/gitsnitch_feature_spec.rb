require 'rails_helper'

# Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
# Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

feature "User can authorise search" do

  before do
    set_omniauth
  end

  it "got show a logout button after search" do
    visit('/')
    click_button('Authorize Search')
    expect(page).to have_button('Log Out')
  end
end
