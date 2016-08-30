class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def index
    'GitSnitch'
  end

end
