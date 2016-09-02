class SnitchController < ApplicationController

  def index
    @results = session[:html]
  end

  def destroy
    @results.destroy
  end

end
