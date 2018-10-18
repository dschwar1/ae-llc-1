class Scope < ActiveRecord::Base
    #Relationships
    has_many :scope_times
    belongs_to :job
    belongs_to :department
    
    #Scopes
    scope :for_job, ->(job_id) { where("job_id = ?", job_id) }
    scope :for_phase, ->(phase) { where("phase = ?", phase) }
    scope :for_cost, ->(cost) { where("cost = ?", cost) }
    scope :chronological, -> { order('estimated_gc_due_date ASC') }
    scope :actual_chronological, -> { order('actual_gc_due_date ASC') }
    scope :between_estimated_dates, ->(start_date, end_date) { where(:estimated_gc_due_date => start_date..end_date) }
    scope :between_actual_dates, ->(start_date, end_date) { where(:actual_gc_due_date => start_date..end_date) }
    scope :actual_date_passed, -> { where("actual_gc_due_date < ?", Date.today) }
    scope :actual_date_nil, -> { where("actual_gc_due_date is NULL") }
    
    #Validations
    validates_presence_of :description, :estimated_gc_due_date, :phase, :cost, :cost_type, :department#, :scope_number #need to add uniqueness per job
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
    
    #Class Methods
    def self.show_incomplete
        scopes = []
        for scope in all.each do
            if !scope.complete?
                scopes.append(scope)
            end
        end
        return Scope.where(id: scopes.map(&:id))
    end
end
