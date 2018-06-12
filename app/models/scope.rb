class Scope < ActiveRecord::Base
    #Relationships
    has_many :scope_times
    belongs_to :job
    belongs_to :department
    
    #Scopes
    #scope :for_job, ->(job_id) { where("job_id = ?", job_id) }
    
end
