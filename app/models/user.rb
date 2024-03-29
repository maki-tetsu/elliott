# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
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
#  crypted_password  :string(255)     not null
#  password_salt     :string(255)     not null
#  persistence_token :string(255)     not null
#  current_login_at  :datetime
#  last_login_at     :datetime
#  current_login_ip  :string(255)
#  last_login_ip     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  admin             :boolean         not null
#

