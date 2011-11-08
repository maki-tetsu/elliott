# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_iphone_format
  helper_method :current_user_session, :current_user

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "ログインしてください。"
      redirect_to new_user_session_url
      return false
    end
  end

  def iphone_request?
    request.user_agent =~ /(Mobile\/.+Safari)/
  end

  def set_iphone_format
    request.format = :iphone if iphone_request?
  end

  def set_layout
    iphone_request? ? "iphone" : "application"
  end
end
