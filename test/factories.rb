#need to add notes and scope_number fields to Scope
#has a lot of overlapping info with seeds.rb
FactoryBot.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    password "MyString"
    role "MyString"
    phone "MyString"
    active false
  end
    
    factory :job do
        name "example job"
        address "123 Example Ave."
        client "Charles Charleston"
        notes "should be green friendly"
        job_number 3456
    end
    
    factory :scope do
        description "Install stairs"
        extra true
        estimated_hours 120
        hours 80
        value 3500
        estimated_gc_due_date 1.week.ago.to_date
        actual_gc_due_date 5.days.ago.to_date
        association :job
        association :department
    end
    
    factory :work_day do
        day 1.day.ago.to_date
        association :job
        association :employee
    end
    
    factory :employee do
        first_name "John"
        last_name "Doe"
        phone 4121231234
        employee_number 7
        association :department
    end
    
    factory :department do
        name "Miscellaneous"
    end
    
    factory :scope_time do
        week Date.today-Date.today.wday
        #hours 80
        completion_rate 80
        association :scope
    end
    
end