class Department < ActiveRecord::Base
    has_many :scopes
    has_many :employees
    
    #Validations
    validates_presence_of :name
end
