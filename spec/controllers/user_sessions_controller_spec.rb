# -*- coding: utf-8 -*-
require 'spec_helper'

describe UserSessionsController do
  describe "GET 'new'" do
    context "ユーザがログインしていないとき" do
      before(:each) do
        get "new"
      end
    end

    context "ユーザがログインしているとき" do
    end
  end
end
