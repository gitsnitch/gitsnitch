class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    token = request.env["omniauth.auth"]["credentials"]["token"]
    @username = request.env["omniauth.auth"]["info"]["nickname"]
    @client = Octokit::Client.new
    @client.access_token = token
    repo_collect
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def repo_collect
    @data = Array.new
    @client.repositories.each do |repo|
      @data << repo.name
    end
    code_search
  end

  def code_search
    results = @client.search_code("facebook user:#{@username}")
    # p "=====================#{results[:items].inspect}================="
  end

  def failure
    redirect_to root_path
  end

end
