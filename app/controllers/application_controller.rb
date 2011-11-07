class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_iphone_format

  def iphone_request?
    request.user_agent =~ /(Mobile\/.+Safari)/
  end

  def set_iphone_format
    request.format = :iphone if iphone_request?
  end

  def set_layout
    iphone_request? ? "iphone" : "application"
  end

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
end
