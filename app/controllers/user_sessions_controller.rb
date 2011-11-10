# -*- coding: utf-8 -*-
class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  # get :new
  def new
    @user_session = UserSession.new
  end

  # post :create
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "ログインしました。"
      redirect_back_or_default(jobs_url)
    else
      flash[:alert] = "ログインに失敗しました。"
      render(:action => :new)
    end
  end

  # delete :destroy
  def destroy
    current_user_session.destroy
    flash[:notice] = "ログアウトしました。"
    redirect_back_or_default(:action => :new)
  end
end
