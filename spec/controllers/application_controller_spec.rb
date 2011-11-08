# -*- coding: utf-8 -*-
require "spec_helper"

describe ApplicationController, "helper methods" do
  describe "current_user_session" do
    before(:each) do
      @user_session_mock = mock(UserSession)
      UserSession.stub(:find).and_return(@user_session_mock)
    end

    context "初回呼び出しの時" do
      it "UserSession.find が呼ばれること" do
        UserSession.should_receive(:find)
        controller.instance_eval {
          current_user_session
        }
      end

      it "インスタンス変数がセットされること" do
        controller.instance_eval {
          current_user_session
        }
        assigns(:current_user_session).should == @user_session_mock
      end
    end

    context "二回目以降の呼び出しのとき" do
      before(:each) do
        controller.instance_eval {
          current_user_session
        }
      end

      it "UserSession.find が呼ばれないこと" do
        UserSession.should_not_receive(:find)
        controller.instance_eval {
          current_user_session
        }
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
        controller.instance_eval {
          current_user
        }
      end

      it "インスタンス変数がセットされること" do
        controller.instance_eval {
          current_user
        }
        assigns(:current_user).should == @user_mock
      end
    end

    context "二回目以降の呼び出し時" do
      before(:each) do
        controller.instance_eval {
          current_user
        }
      end

      it "UserSession.find が呼ばれないこと" do
        UserSession.should_not_receive(:find)
        controller.instance_eval {
          current_user
        }
      end

      it "UserSession.find.user が呼ばれないこと" do
        UserSession.should_not_receive(:find)
        @user_session_mock.should_not_receive(:user)
        controller.instance_eval {
          current_user
        }
      end
    end
  end
end

describe ApplicationController, "require user session filter method" do
  describe "#store_location" do
    before(:each) do
      @uri = "/"
      request.stub(:request_uri).and_return(@uri)
    end

    it "request.request_uri が呼ばれること" do
      request.should_receive(:request_uri).and_return(@uri)
      controller.instance_eval {
        store_location
      }
    end

    it "session[:return_to] に URI が設定されること" do
      controller.instance_eval {
        store_location
      }
      session[:return_to].should == @uri
    end
  end

  describe "#redirect_back_or_default" do
    before(:each) do
      @return_to = "/"
    end

    context "redirect 先が登録されているとき" do
      before(:each) do
        session[:return_to] = @return_to
      end

      it "redirect 先にリダイレクトされること" do
        controller.should_receive(:redirect_to).with(@return_to)
        controller.instance_eval {
          redirect_back_or_default("/somewhere")
        }
      end

      it "redirect 先が nil になること" do
        controller.stub(:redirect_to)
        controller.instance_eval {
          redirect_back_or_default("/somewhere")
        }
        session[:return_to].should be_nil
      end
    end

    context "リダイレクト先が登録されていないとき" do
      before(:each) do
        session[:return_to] = nil
      end

      it "指定されたデフォルト URI に転送されること" do
        controller.should_receive(:redirect_to).with("/somewhere")
        controller.instance_eval {
          redirect_back_or_default("/somewhere")
        }
      end
    end
  end

  describe "#require_user" do
    context "ユーザセッションが存在しない時" do
      before(:each) do
        controller.stub(:current_user).and_return(nil)
        controller.stub(:redirect_to)
        controller.stub(:store_location)
      end

      it "ログインアクションにリダイレクトされること" do
        controller.should_receive(:redirect_to).with(new_user_session_url)
        controller.instance_eval {
          require_user
        }
      end

      it "store_location が呼ばれること" do
        controller.should_receive(:store_location)
        controller.instance_eval {
          require_user
        }
      end

      it "flash[:notice] に「ログインしてください。」が設定されること" do
        controller.instance_eval {
          require_user
        }
        flash[:notice].should == "ログインしてください。"
      end

      it "false が返却されること" do
        controller.instance_eval {
          require_user
        }.should be_false
      end
    end

    context "ユーザセッションが存在する時" do
      before(:each) do
        @user_mock = mock_model(User)
        controller.stub(:current_user).and_return(@user_mock)
      end

      it "リダイレクトされないこと" do
        controller.should_not_receive(:redirect_to)
        controller.instance_eval {
          require_user
        }
      end

      it "false もしくは nil が返却されないこと" do
        controller.instance_eval {
          require_user
        }.should_not == false
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
      controller.send(:iphone_request?).should be_true
    end
  end

  context "iPhone以外からのアクセスの時" do
    before(:each) do
      request.env['HPPT_USER_AGENT'] = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0 Safari/533.16'
    end

    it "false が返されること" do
      controller.send(:iphone_request?).should be_false
    end
  end
end

describe ApplicationController, "#set_layout" do
  context "iPhoneからのアクセスの時" do
    before(:each) do
      request.env['HTTP_USER_AGENT'] = 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_0 like Mac OS X; ja-jp) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/5A345 Safari/525.20'
    end

    it "iphone が返されること" do
      controller.send(:set_layout).should == "iphone"
    end
  end

  context "iPhone以外からのアクセスの時" do
    before(:each) do
      request.env['HPPT_USER_AGENT'] = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0 Safari/533.16'
    end

    it "application が返されること" do
      controller.send(:set_layout).should == "application"
    end
  end
end
