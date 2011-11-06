class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, :limit => 40, :null => false
      t.string :first_name, :limit => 100, :null => false
      t.string :family_name, :limit => 100, :null => false
      t.string :nickname, :limit => 20
      t.string :email, :limit => 255, :null => false
      t.integer :access_level, :null => false
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip

      t.timestamps
    end

    add_index(:users, :login, :unique => true)
    add_index(:users, :email, :unique => true)
  end
end
