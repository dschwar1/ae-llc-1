class ScopeTime < ActiveRecord::Base
    #Relationships
    belongs_to :scope
    belongs_to :department
    
    
    #Validations
    validates_presence_of :week
    validate :completion_rate_correct
    
    #Callbacks
    before_create :standarize_week
    
    #Methods
    private
    def standarize_week
        self.week = self.week.to_date - self.week.to_date.wday + 6
    end
    
    def completion_rate_correct
        unless self.completion_rate >= 1 && self.completion_rate <= 100
            self.errors.add(:completion_rate, "is incorrect. Make sure it's between 1 and 100 .")
        end
        unless (self.scope.completion_rate + self.completion_rate) <= 100
            self.errors.add(:completion_rate, "is incorrect. Make sure the total for that scope will not exceed 100.")
        end
    end
end
