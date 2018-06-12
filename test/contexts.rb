module Contexts
    def build_context
        @job = FactoryBot.create(:job)
        @department = FactoryBot.create(:department)
        @scope = FactoryBot.create(:scope, job: @job, department: @department)
        @employee = FactoryBot.create(:employee)
        @scope_time = FactoryBot.create(:scope_time, scope: @scope)
        @work_day = FactoryBot.create(:work_day, job: @job, employee: @employee)
    end
    
    def destroy_context
       @job.delete
       @department.delete
       @scope.delete
       @employee.delete
       @scope_time.delete
       @work_day.delete
    end
end