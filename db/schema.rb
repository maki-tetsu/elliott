# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111115111854) do

  create_table "jobs", :force => true do |t|
    t.string   "code",                    :limit => 7, :null => false
    t.string   "name",                                 :null => false
    t.string   "description"
    t.string   "customer"
    t.date     "due_date"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "budget"
    t.date     "estimate_submitted_date"
    t.integer  "register_id",                          :null => false
    t.string   "register_name",                        :null => false
    t.datetime "registed_at",                          :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["code"], :name => "index_jobs_on_code", :unique => true

  create_table "users", :force => true do |t|
    t.string   "login",             :limit => 40,  :null => false
    t.string   "first_name",        :limit => 100, :null => false
    t.string   "family_name",       :limit => 100, :null => false
    t.string   "nickname",          :limit => 20
    t.string   "email",                            :null => false
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                            :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
