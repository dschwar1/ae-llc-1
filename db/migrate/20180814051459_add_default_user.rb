class AddDefaultUser < ActiveRecord::Migration
  def up
    admin = User.new
    admin.first_name = "Admin"
    admin.last_name = "Admin"
    admin.email = "admin@example.com"
    admin.password = "Einstein1984"
    admin.password_confirmation = "Einstein1984"
    admin.role = "admin"
    admin.save!
  end
  
  def down
    admin = User.find_by_email "admin@example.com"
    User.delete admin
  end
end
