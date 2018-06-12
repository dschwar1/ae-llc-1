class Department < ActiveRecord::Base
    has_many :scopes
    has_many :employees
end
