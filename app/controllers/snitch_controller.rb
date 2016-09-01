class SnitchController < ApplicationController

  def index
    @user = session[:html]
  end

  def destroy
    @user.destroy
  end


end
