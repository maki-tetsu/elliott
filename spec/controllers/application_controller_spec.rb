# -*- coding: utf-8 -*-
require "spec_helper"

describe ApplicationController, "helper methods" do
  describe "current_user_session" do
    before(:each) do
      user_session_mock = mock(UserSession)
      UserSession.stub(:find).and_return(user_session_mock)
    end

    context "初回呼び出しの時" do
      it "UserSession.find が呼ばれること" do
        UserSession.should_receive(:find)
        controller.send(:current_user_session)
      end

      it "インスタンス変数がセットされること" do
        controller.send(:current_user_session)
        controller.instance_eval("defined?(@current_user_session)").should be_true
      end
    end

    context "二回目以降の呼び出しのとき" do
      before(:each) do
        controller.send(:current_user_session)
      end

      it "UserSession.find が呼ばれないこと" do
        UserSession.should_not_receive(:find)
        controller.send(:current_user_session)
      end
    end
  end

  describe "current_user" do
    before(:each) do
      @user_session_mock = mock(UserSession)
      @user_mock = mock_model(User)
      UserSession.stub(:find).and_return(@user_session_mock)
      @user_session_mock.stub(:user).and_return(@user_mock)
    end

    context "初回呼び出しのとき" do
      it "UserSession.find.user が呼ばれること" do
        UserSession.should_receive(:find)
        @user_session_mock.should_receive(:user)
        controller.send(:current_user)
      end

      it "インスタンス変数がセットされること" do
        controller.send(:current_user)
        controller.instance_eval("defined?(@current_user)").should be_true
      end
    end

    context "二回目以降の呼び出し時" do
      before(:each) do
        controller.send(:current_user)
      end

      it "UserSession.find が呼ばれないこと" do
        UserSession.should_not_receive(:find)
        controller.send(:current_user)
      end

      it "UserSession.find.user が呼ばれないこと" do
        UserSession.should_not_receive(:find)
        @user_session_mock.should_not_receive(:user)
        controller.send(:current_user)
      end
    end
  end
end
