class Employee < ActiveRecord::Base
    #Relationships
    has_many :work_days
    has_many :jobs, through: :work_days
    belongs_to :department
    
end
