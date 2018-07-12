class CreateWorkDays < ActiveRecord::Migration
  def change
    create_table :work_days do |t|
      t.datetime :day
      t.integer :job_id
      t.integer :employee_id

      t.timestamps null: false
    end
  end
end
