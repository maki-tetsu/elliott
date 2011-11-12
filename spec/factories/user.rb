# -*- coding: utf-8 -*-
Factory.define :user do |u|
  u.login "taro"
  u.first_name "太郎"
  u.family_name "田中"
  u.nickname "タロー"
  u.email "taro@example.com"
  u.admin false
  u.password "taro"
  u.password_confirmation "taro"
end

Factory.define :admin, :parent => :user do |a|
  a.login "admin"
  a.first_name "システム管理者"
  a.family_name ""
  a.nickname "シスアド"
  a.email "root@example.com"
  a.admin true
  a.password "admin"
  a.password_confirmation "admin"
end
