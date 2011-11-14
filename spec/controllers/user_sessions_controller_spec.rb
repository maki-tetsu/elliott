# -*- coding: utf-8 -*-
require 'spec_helper'

activate_authlogic

describe UserSessionsController do
  describe "GET 'new'" do
    before(:each) do
      @user_session_mock = stub_model(UserSession)
      UserSession.stub(:new).and_return(@user_session_mock)
      controller.stub(:require_no_user).and_return(true)
    end

    describe :routes do
      subject { {:get => "/user_session/new"} }
      it { should route_to(controller: "user_sessions", action: "new") }
    end

    it {
      get :new

      response.should be_success
      response.should render_template(:new)
    }

    it "UserSession.new が呼ばれること" do
      UserSession.should_receive(:new)

      get :new
    end

    it "@user_session が設定されること" do
      get :new

      assigns(:user_session).should == @user_session_mock
    end

    it "require_no_user フィルタが呼ばれること" do
      controller.should_receive(:require_no_user)

      get :new
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @user_session_mock = stub_model(UserSession)
      @params = { :user_session => { "login" => "login", "password" => "password" } }
      controller.stub(:require_no_user).and_return(true)

      UserSession.stub(:new).with(@params[:user_session]).and_return(@user_session_mock)
    end

    describe :routes do
      subject { {:post => "/user_session"} }
      it { should route_to(controller: "user_sessions", action: "create") }
    end

    it "require_no_user フィルタが呼ばれること" do
      controller.should_receive(:require_no_user)
      @user_session_mock.stub(:save)

      post :create, @params
    end

    context "認証に成功する時" do
      before(:each) do
        @user_session_mock.stub(:save).and_return(true)
      end

      it "ジョブ一覧に遷移すること" do
        post :create, @params

        response.should redirect_to(:controller => :jobs, :action => :index)
      end

      it "UserSession.new が呼ばれること" do
        UserSession.should_receive(:new).with(@params[:user_session])

        post :create, @params
      end

      it "UserSession#save が呼ばれること" do
        @user_session_mock.should_receive(:save)

        post :create, @params
      end

      it "flash[:notice] が設定されること" do
        post :create, @params

        flash[:notice].should == "ログインしました。"
      end
    end

    context "認証に失敗する時" do
      before(:each) do
        @user_session_mock.stub(:save).and_return(false)
      end

      it ":action => new が表示されること" do
        post :create, @params

        response.should be_success
        response.should render_template(:new)
      end

      it "UserSession.new が呼ばれること" do
        UserSession.should_receive(:new).with(@params[:user_session])

        post :create, @params
      end

      it "UserSession#save が呼ばれること" do
        @user_session_mock.should_receive(:save)

        post :create, @params
      end

      it "flash[:alert] が設定されること" do
        post :create, @params

        flash[:alert].should == "ログインに失敗しました。"
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @user_session_mock = stub_model(UserSession)
      controller.stub(:require_user).and_return(true)
      controller.stub(:current_user_session).and_return(@user_session_mock)
      @user_session_mock.stub(:destroy)
    end

    describe :routes do
      subject { {:delete => "/user_session"} }
      it { should route_to(controller: "user_sessions", action: "destroy") }
    end

    it "require_user フィルタが呼ばれること" do
      controller.should_receive(:require_user)

      delete :destroy
    end

    it "current_user_session.destroy が呼ばれること" do
      controller.should_receive(:current_user_session).and_return(@user_session_mock)
      @user_session_mock.should_receive(:destroy)

      delete :destroy
    end

    it "flash[:notice] が設定されること" do
      delete :destroy

      flash[:notice].should == "ログアウトしました。"
    end

    it "ログイン画面にリダイレクトされること" do
      delete :destroy

      response.should redirect_to(:action => :new)
    end
  end
end
