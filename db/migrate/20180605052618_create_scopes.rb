class CreateScopes < ActiveRecord::Migration
  def change
    create_table :scopes do |t|
      t.string :scope_number
      t.text :notes
      t.string :description
      t.boolean :extra, default: false
      t.integer :estimated_hours
      t.integer :hours, default: 0
      t.float :value, default: 0
      t.datetime :estimated_gc_due_date
      t.datetime :actual_gc_due_date
      t.integer :crew_size
      t.integer :job_id
      t.integer :department_id

      t.timestamps null: false
    end
  end
end
