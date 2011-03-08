class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :mobile

  before_filter :set_time_zone
  before_filter :prepare_for_mobile

  def mobile
    session[:mobile_param] = "1"
    redirect_to root_path
  end

  def fullsite
    session[:mobile_param] = "0"
    redirect_to root_path
  end

  protected

  def set_time_zone
    if current_user
      Time.zone = current_user.time_zone
      Chronic.time_class = Time.zone
    end
  end

  def mobile_user_agent?
    request.user_agent =~ /Mobile/
  end
  helper_method :mobile_user_agent?

  def mobile_site_requested?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      mobile_user_agent?
    end
  end
  helper_method :mobile_site_requested?

  def prepare_for_mobile
    request.format = :mobile if mobile_site_requested?
  end

end
