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

describe ApplicationController, "#iphone_request?" do
  context "iPhoneからのアクセスの時" do
    before(:each) do
      request.env['HTTP_USER_AGENT'] = 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_0 like Mac OS X; ja-jp) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/5A345 Safari/525.20'
    end

    it "true が返されること" do
      controller.iphone_request?.should be_true
    end
  end

  context "iPhone意外からのアクセスの時" do
    before(:each) do
      request.env['HPPT_USER_AGENT'] = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0 Safari/533.16'
    end

    it "false が返されること" do
      controller.iphone_request?.should be_false
    end
  end
end

describe ApplicationController, "#set_layout" do
  context "iPhoneからのアクセスの時" do
    before(:each) do
      request.env['HTTP_USER_AGENT'] = 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_0 like Mac OS X; ja-jp) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/5A345 Safari/525.20'
    end

    it "iphone が返されること" do
      controller.set_layout.should == "iphone"
    end
  end

  context "iPhone意外からのアクセスの時" do
    before(:each) do
      request.env['HPPT_USER_AGENT'] = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0 Safari/533.16'
    end

    it "application が返されること" do
      controller.set_layout.should == "application"
    end
  end
end
