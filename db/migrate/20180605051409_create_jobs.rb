class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :address
      t.string :client
      t.text :notes
      t.string :job_number

      t.timestamps null: false
    end
  end
end
