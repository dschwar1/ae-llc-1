class WorkDay < ActiveRecord::Base
    #Relationships
    belongs_to :job
    belongs_to :employee
    
end
