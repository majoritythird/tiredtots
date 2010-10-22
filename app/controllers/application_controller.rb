class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html

  def current_user
    User.first
  end

end
