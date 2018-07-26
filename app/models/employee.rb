class Employee < ActiveRecord::Base
    #Relationships
    has_many :work_days
    has_many :jobs, through: :work_days
    belongs_to :department
    
    #Methods
    def name
        return self.first_name + " " + self.last_name
    end
    
end
