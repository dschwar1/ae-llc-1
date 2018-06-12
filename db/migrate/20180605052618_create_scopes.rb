class CreateScopes < ActiveRecord::Migration
  def change
    create_table :scopes do |t|
      t.boolean :extra
      t.integer :estimated_hours
      t.float :value
      t.datetime :estimated_gc_due_date
      t.datetime :actual_gc_due_date
      t.integer :job_id
      t.integer :department_id

      t.timestamps null: false
    end
  end
end
