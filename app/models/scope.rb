class Scope < ActiveRecord::Base
    #Relationships
    has_many :scope_times
    belongs_to :job
    belongs_to :department
    
    #Scopes
    scope :for_job, ->(job_id) { where("job_id = ?", job_id) }
    
    #Methods
    def completion_rate
        total = 0
        for scope_time in self.scope_times.to_a do
            total += scope_time.completion_rate
        end
        return total
    end
    
    def complete?
        if self.completion_rate == 100
            return true
        else
            return false
        end
    end
    
    def hours_left
        return self.estimated_hours * (100 - self.completion_rate)/100
    end
end
