module Contexts
    def build_context
        @job1 = FactoryBot.create(:job)
        @job2 = FactoryBot.create(:job, name: "CMU Maintenance", client: "CMU", notes: "None", job_number: 3444, address: "5000 Forbes Ave.")
        @department1 = FactoryBot.create(:department)
        @department2 = FactoryBot.create(:department, name: "Pre-Engineering")
        @scope1 = FactoryBot.create(:scope, job: @job1, department: @department1)
        @scope2 = FactoryBot.create(:scope, job: @job1, department: @department1, description: "Install railing", estimated_hours: 100, actual_gc_due_date: 1.day.from_now, value: 800)
        @employee1 = FactoryBot.create(:employee, department: @department1)
        @employee2 = FactoryBot.create(:employee, department: @department2, first_name: "Jane", last_name: "Doe", phone: "4124124112", employee_number: "2")
        @scope_time1 = FactoryBot.create(:scope_time, scope: @scope1)
        @scope_time2 = FactoryBot.create(:scope_time, scope: @scope1, week: 1.week.ago.to_date-1.week.ago.to_date.wday, hours: 40, completion_rate: 30)
        @work_day1 = FactoryBot.create(:work_day, job: @job1, employee: @employee1)
        @work_day2 = FactoryBot.create(:work_day, job: @job1, employee: @employee1, day: Date.today)
    end
    
    def destroy_context
       @job1.delete
       @job2.delete
       @department1.delete
       @department2.delete
       @scope1.delete
       @scope2.delete
       @employee1.delete
       @employee2.delete
       @scope_time1.delete
       @scope_time2.delete
       @work_day1.delete
       @work_day2.delete
    end
end