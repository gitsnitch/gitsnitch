require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController do

  TOKEN_LENGTH = 32
  REDIRECT_STATUS = 302

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    @token = @request.env["omniauth.auth"].credentials.token
    @username = @request.env["omniauth.auth"].info.nickname
    @email = @request.env['omniauth.auth'].info.email
    get :github
  end

  describe 'Data for octokit' do

    it "should return the correct access token" do
      expect(@token.length).to eq(TOKEN_LENGTH)
    end

    it "should return the correct username" do
      expect(@username).to eq('BigBerta')
    end

  end

  describe 'authorizing' do

    it 'saves user when authenticated' do
      user = User.from_omniauth(@request.env["omniauth.auth"])
      expect(user.persisted?).to be_truthy
    end

    it 'response data is accurate' do
      expect(@email).to eq('fake@example.com')
    end

    it "redirects http request" do
      expect(response).to have_http_status(REDIRECT_STATUS)
    end

    it "should redirect to the home page" do
      expect(response).to redirect_to(root_path)
    end

    it "should fail with invalid credentials" do
      OmniAuth.config.mock_auth[:github] = :invalid_credentials
      expect(response).not_to be_success
    end

  end

end
