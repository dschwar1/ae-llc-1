class Job < ActiveRecord::Base
    #Relationships
    has_many :work_days
    has_many :scopes
    has_many :employees, through: :work_days
    
    #Scopes
    #scope :active_jobs, -> { where("Job.active?") }
    scope :for_scope_phase, ->(phase) { joins(:scopes).where('scopes.phase = ?', phase).distinct }
    scope :for_scope_cost, ->(cost) { joins(:scopes).where('scopes.cost = ?', cost).distinct }
    scope :for_job_number, ->(job_num) { where("job_number = ?", job_num) }
    scope :for_job_name, ->(name) { where('lower(name) LIKE ?', "#{name.downcase}%") }
    scope :between_scope_estimated_dates, ->(start_date, end_date) { joins(:scopes).where('? < scopes.estimated_gc_due_date AND ? > scopes.estimated_gc_due_date', start_date, end_date).distinct }
    scope :between_scope_actual_dates, ->(start_date, end_date) { joins(:scopes).where('? < scopes.actual_gc_due_date AND ? > scopes.actual_gc_due_date', start_date, end_date).distinct }
    scope :scope_actual_date_passed, -> { joins(:scopes).where("scopes.actual_gc_due_date < ?", Date.today).distinct }
    scope :scope_actual_date_nil, -> { joins(:scopes).where("scopes.actual_gc_due_date is NULL").distinct }
    
    #Validations
    validates_presence_of :name, :client
    validates :job_number, presence: true, uniqueness: { case_sensitive: false }
    
    #Methods
    def active?
        for scope in Scope.all.for_job(self.id).to_a do
            if scope.actual_gc_due_date < 2.weeks.from_now.to_date and !scope.complete?
                return true
            end
        end
        return false
    end
    
    def incomplete?
        for scope in Scope.all.for_job(self.id).to_a do
            if !scope.complete?
                return true
            end
        end
        return false
    end
    
    #need to pass in department name, not record
    def department?(dep)
        for scope in Scope.all.for_job(self.id).to_a do
            if scope.department.name == dep
                return true
            end
        end
        return false
    end
    
    def total_hours_left
        total = 0
        for scope in Scope.all.for_job(self.id).to_a do
            total += scope.hours_left
        end
        return total
    end
    
    #Class Methods
    #These return Active Record Relations, not individual models
    def self.active_jobs
        jobs = []
        for job in Job.all.each do
            if job.active?
                jobs.append(job)
            end
        end
        return Job.where(id: jobs.map(&:id))
    end
    
    def self.for_department(dep)
        jobs = []
        for job in self.all.each do
            if job.department?(Department.find(dep).name)
                jobs.append(job)
            end
        end
        #if(jobs == [])
        #    return self.all
        #end
        return Job.where(id: jobs.map(&:id))
        #return Job.where('id in jobs')
    end
    #Use both class methods for scheduling page(separated by department and only shows active jobs)
    
    def self.incomplete_jobs
        jobs = []
        for job in Job.all.each do
            if job.incomplete?
                jobs.append(job)
            end
        end
        return Job.where(id: jobs.map(&:id))
    end
    
end
