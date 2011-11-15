# -*- coding: utf-8 -*-
require "spec_helper"

describe "user_sessions/new.iphone.erb" do 
  context "初回表示の時" do 
    before do 
      activate_authlogic
      @user_session = assign(:user_session,
                             stub_model(UserSession).
                             as_new_record)

      render
    end

    it { 
      assert_select "form", :action => user_session_path(@user_session), :method => "post" do 
        assert_select "input#user_session_login", :name => "user_session[login]", :value => ""
        assert_select "input#user_session_password", :name => "user_session[password]", :value => "", :type => "password"
      end
    }
  end

  context "ログイン失敗で再描画される時" do 
    before do 
      activate_authlogic
      @user_session = assign(:user_session,
                             stub_model(UserSession,
                                        :login => "login",
                                        :password => "").
                             as_new_record)
      flash[:alert] = "ログインに失敗しました。"

      render
    end

    it "alert の内容が表示されること" do 
      rendered.should =~ /#{flash[:alert]}/
    end

    it "ログインIDが自動で表示されること" do 
      assert_select "form", :action => user_session_path(@user_session), :method => "post" do 
        assert_select "input#user_session_login", :name => "user_session[login]", :value => "login"
        assert_select "input#user_session_password", :name => "user_session[password]", :value => "", :type => "password"
      end
    end
  end
end
