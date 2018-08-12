class CreateScopes < ActiveRecord::Migration
  def change
    create_table :scopes do |t|
      t.string :scope_number
      t.string :notes
      t.string :description
      t.boolean :extra
      t.integer :estimated_hours
      t.integer :hours
      t.float :value
      t.datetime :estimated_gc_due_date
      t.datetime :actual_gc_due_date
      t.integer :crew_size
      t.integer :job_id
      t.integer :department_id

      t.timestamps null: false
    end
  end
end
