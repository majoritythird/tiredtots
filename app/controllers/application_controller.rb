class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html

  before_filter :set_time_zone

  protected

  def set_time_zone
    if current_user
      Time.zone = current_user.time_zone
      Chronic.time_class = Time.zone
    end
  end

end
