class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :code, :limit => 7, :null => false
      t.string :name, :limit => 255, :null => false
      t.string :description, :limit => 255
      t.string :customer, :limit => 255
      t.date :due_date
      t.date :start_date
      t.date :end_date
      t.decimal :budget, :precesion => 10, :scale => 0
      t.date :estimate_submitted_date
      t.integer :register_id, :null => false
      t.string :register_name, :null => false, :limit => 255
      t.datetime :registed_at, :null => false
      t.text :note

      t.timestamps
    end

    add_index :jobs, :code, :unique => true
  end
end
