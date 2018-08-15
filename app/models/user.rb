class User < ActiveRecord::Base
    #Use Bcrypt gem to hash passwords
    has_secure_password
    
    #Validations
    validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
    validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
    validates :role, inclusion: { in: %w[admin foreman], message: "is not a recognized role in system" }
    validates_presence_of :password, :first_name, :last_name
    
    #Authentication
    ROLES = [['Administrator', :admin],['Foreman', :foreman]]
    
    def role?(authorized_role)
	    return false if role.nil?
	    role.downcase.to_sym == authorized_role
    end
end
