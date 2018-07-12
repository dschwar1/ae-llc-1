class CreateScopeTimes < ActiveRecord::Migration
  def change
    create_table :scope_times do |t|
      t.datetime :week
      #t.integer :hours
      t.integer :completion_rate
      t.integer :scope_id

      t.timestamps null: false
    end
  end
end
