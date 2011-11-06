# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  ### ユーザのアクセスレベル定義
  ACCESS_LEVELS = {
    :user  => 1, # 一般ユーザ
    :admin => 2, # システム管理者
  }
  ACCESS_LEVEL_NAMES = {
    :user  => "一般ユーザ",
    :admin => "システム管理者",
  }

  # authlogic setup
  acts_as_authentic do |c|
    # login
    c.merge_validates_length_of_login_field_options :within => 1..40
    c.validate_login_field
    # email
    c.merge_validates_length_of_email_field_options :maximum => 255
    c.validate_email_field
    # password
    c.require_password_confirmation
    c.validate_password_field
  end

  # first_name validations
  validates :first_name, :length => { :within => 1..100 }
  # family_name validations
  validates :family_name, :length => { :maximum => 100, :allow_blank => true }
  # nickname
  validates :nickname, :length => { :maximum => 20, :allow_blank => true }
  # access_level
  validates :access_level, :inclusion => { :in => ACCESS_LEVELS.values }
end
