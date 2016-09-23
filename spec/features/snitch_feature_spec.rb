require 'rails_helper'

feature 'Snitch' do

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

    scenario 'should succefully log in via github' do
      # VCR.use_cassette('omniauth', :record => :new_episodes) do
      #   Capybara.current_driver = :mechanize
        visit '/'
        click_button 'Authorize Search'
        expect(page).to have_button 'Log Out'
    # end
  end

end
