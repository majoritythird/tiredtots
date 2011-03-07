class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html

  before_filter :set_time_zone
  before_filter :prepare_for_mobile

  protected

  def set_time_zone
    if current_user
      Time.zone = current_user.time_zone
      Chronic.time_class = Time.zone
    end
  end

  def mobile_device?
    request.user_agent =~ /Mobile/
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    request.format = :mobile if mobile_device?
  end

end
