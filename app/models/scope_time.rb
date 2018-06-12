class ScopeTime < ActiveRecord::Base
    #Relationships
    belongs_to :scope
    belongs_to :department
    
end
