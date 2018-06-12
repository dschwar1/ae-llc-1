class Job < ActiveRecord::Base
    #Relationships
    has_many :work_days
    has_many :scopes
    has_many :employees, through: :work_days
    
    #Scopes
    
    #Methods
    def active_job
        Scope.all.for_job(self.id)
        return False
    end
end
