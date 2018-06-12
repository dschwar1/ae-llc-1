class WorkDay < ActiveRecord::Base
    #Relationships
    belongs_to :job
    belongs_to :employee
    
    #Scopes
    scope :for_week, ->(week) { where("day >= ? and day < ?", week-week.wday, week-week.wday+7.days) }
    scope :for_job, ->(job_id) { where("job_id = ?", job_id) }
    
end
