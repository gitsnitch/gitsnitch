require './lib/octokit'


class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      account_verified
      octokit_client_create
    else
      account_not_verified
    end
  end

  def account_verified
    sign_in_and_redirect @user, :event => :authentication
    set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
  end

  def account_not_verified
    session["devise.github_data"] = request.env["omniauth.auth"]
    redirect_to new_user_registration_url
  end

  def failure
    redirect_to root_path
  end

  def octokit_client_create
    token = request.env["omniauth.auth"]["credentials"]["token"]
    username = request.env["omniauth.auth"]["info"]["nickname"]
    @client = OctokitClient.new(token, username)
    github_results
  end

  def github_results
    session[:html] = @client.fragment_return
  end

end
