class SnitchController < ApplicationController

  def index
    @user = session[:html]
  end
end
