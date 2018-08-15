class Scope < ActiveRecord::Base
    #Relationships
    has_many :scope_times
    belongs_to :job
    belongs_to :department
    
    #Scopes
    scope :for_job, ->(job_id) { where("job_id = ?", job_id) }
    
    #Validations
    validates_presence_of :scope_number, :description, :estimated_gc_due_date #need to add uniqueness per job
    validates_numericality_of :estimated_hours, greater_than_or_equal_to: 0
    validates_numericality_of :hours, greater_than_or_equal_to: 0
    validates_numericality_of :value, greater_than_or_equal_to: 0
    validates_numericality_of :crew_size, greater_than_or_equal_to: 0, :allow_nil => true
    
    
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
