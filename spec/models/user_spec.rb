# -*- coding: utf-8 -*-
require 'spec_helper'

describe User, "の検証について" do
  context "すべての項目に問題がないとき" do
    before(:each) do 
      @user = Factory.build(:user)
    end

    subject { @user }
    
    it { should be_valid }
  end

  context "#login について" do 
    context "#login がブランクのとき" do 
      before(:each) do 
        @user = Factory.build(:user, :login => "")
      end

      subject { @user }

      it { should_not be_valid }
    end

    context "#first_name がブランクのとき" do
      before(:each) do 
        @user = Factory.build(:user, :first_name => "")
      end

      subject { @user }

      it { should_not be_valid }
    end

    context "#first_name 100 文字のとき" do
      before(:each) do 
        @user = Factory.build(:user, :first_name => "a"*100)
      end

      subject { @user }

      it { should be_valid }
    end

    context "#first_name 101 文字のとき" do
      before(:each) do 
        @user = Factory.build(:user, :first_name => "a"*101)
      end

      subject { @user }

      it { should_not be_valid }
    end
  end

  context "#family_name について" do 
    context "#family_name がブランクのとき" do
      before(:each) do 
        @user = Factory.build(:user, :family_name => "")
      end

      subject { @user }

      it { should be_valid }
    end

    context "#family_name 100 文字のとき" do
      before(:each) do 
        @user = Factory.build(:user, :family_name => "a"*100)
      end

      subject { @user }

      it { should be_valid }
    end

    context "#family_name 101 文字のとき" do
      before(:each) do 
        @user = Factory.build(:user, :family_name => "a"*101)
      end

      subject { @user }

      it { should_not be_valid }
    end
  end
  
  context "#nickname について" do 
    context "#nickname がブランクのとき" do
      before(:each) do 
        @user = Factory.build(:user, :nickname => "")
      end

      subject { @user }

      it { should be_valid }
    end

    context "#nickname 20 文字のとき" do
      before(:each) do 
        @user = Factory.build(:user, :nickname => "a"*20)
      end

      subject { @user }

      it { should be_valid }
    end

    context "#nickname 21 文字のとき" do
      before(:each) do 
        @user = Factory.build(:user, :nickname => "a"*21)
      end

      subject { @user }

      it { should_not be_valid }
    end
  end

  context "#access_level について" do 
    context "#access_level がブランクとき" do 
      before(:each) do 
        @user = Factory.build(:user, :access_level => "")
      end

      subject { @user }
      
      it { should_not be_valid }
    end

    context "#access_level が User::ACCESS_LEVELS[:user] のとき" do 
      before(:each) do 
        @user = Factory.build(:user, :access_level => User::ACCESS_LEVELS[:user])
      end

      subject { @user }
      
      it { should be_valid }
    end

    context "#access_level が User::ACCESS_LEVELS[:admin] のとき" do 
      before(:each) do 
        @user = Factory.build(:user, :access_level => User::ACCESS_LEVELS[:admin])
      end

      subject { @user }
      
      it { should be_valid }
    end

    context "#access_level が 0 のとき" do 
      before(:each) do 
        @user = Factory.build(:user, :access_level => 0)
      end

      subject { @user }
      
      it { should_not be_valid }
    end
  end
end
# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  login             :string(40)      not null
#  first_name        :string(100)     not null
#  family_name       :string(100)     not null
#  nickname          :string(20)
#  email             :string(255)     not null
#  access_level      :integer         not null
#  crypted_password  :string(255)     not null
#  password_salt     :string(255)     not null
#  persistence_token :string(255)     not null
#  current_login_at  :datetime
#  last_login_at     :datetime
#  current_login_ip  :string(255)
#  last_login_ip     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

