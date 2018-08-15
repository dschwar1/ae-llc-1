class Employee < ActiveRecord::Base
    #Relationships
    has_many :work_days
    has_many :jobs, through: :work_days
    belongs_to :department
    
    #Validations
    validates_presence_of :first_name, :last_name
    validates :employee_number, presence: true, uniqueness: { case_sensitive: false }
    validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
    
    #Methods
    def name
        return self.first_name + " " + self.last_name
    end
    
end
