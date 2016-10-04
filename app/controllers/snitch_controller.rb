class SnitchController < ApplicationController

  def index
    @results = []
    if current_user
      user = User.find(current_user)
      @results << Issue.find_by(user_id: user.id)
    end
  end

  def destroy
    @results.destroy
  end

end
