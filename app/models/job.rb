class Job < ActiveRecord::Base
    #Relationships
    has_many :work_days
    has_many :scopes
    has_many :employees, through: :work_days
    
    #Scopes
    scope :active_jobs, -> { where("Job.active?") }
    
    #Methods
    def active?
        for scope in Scope.all.for_job(self.id).to_a do
            if scope.actual_gc_due_date > 1.week.ago.to_date and !scope.complete?
                return true
            end
        end
        return false
    end
    
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
        for job in Job.all.each do
            if job.department?(dep)
                jobs.append(job)
            end
        end
        return Job.where(id: jobs.map(&:id))
    end
    #Use both class methods for scheduling page(separated by department and only shows active jobs)
end
