class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :employee_number
      t.integer :department_id

      t.timestamps null: false
    end
  end
end
