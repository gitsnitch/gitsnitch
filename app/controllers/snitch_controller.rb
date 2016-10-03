class SnitchController < ApplicationController

  def index
    # @results = session[:html]
    # @results = Issue.find_by(user_id: 1)
    if current_user
      user = User.find(current_user)
      @results = Issue.find_by(user_id: user.id)
      p "=======================#{@results.inspect}"
    end
  end

  def destroy
    @results.destroy
  end

end
