# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Job.create(name: "example job", address: "123 Example Ave.", client: "Charles Charleston", notes: "should be green friendly", job_number: '3456')
Job.create(name: "CMU Maintenance", address: "5000 Forbes Ave.", client: "CMU", notes: "None", job_number: '3444')
Department.create(name: "Miscellaneous")
Department.create(name: "Pre-Engineering")
Employee.create(first_name: "John", last_name: "Doe", phone: 4121231234, employee_number: 7, department_id: Department.first.id)
Employee.create(first_name: "Jane", last_name: "Doe", phone: 4121231235, employee_number: 8, department_id: Department.second.id)
Scope.create(description: "Install stairs", extra: true, estimated_hours: 120, hours: 80, value: 3500, estimated_gc_due_date: 1.week.ago.to_date, actual_gc_due_date: 5.days.ago.to_date, job_id: Job.first.id, department_id: Department.first.id, phase: "D", cost: '01', cost_type: 'L', notes: "None", crew_size: 3)
Scope.create(description: "Install railing", extra: false, estimated_hours: 100, hours: 100, value: 3000, estimated_gc_due_date: 2.weeks.ago.to_date, actual_gc_due_date: 3.days.ago.to_date, job_id: Job.second.id, department_id: Department.second.id, phase: "O", cost: '01', cost_type: 'L', notes: "Get done quick", crew_size: 4)
Scope.create(description: "Put in lights", extra: false, estimated_hours: 60, hours: 40, value: 4000, estimated_gc_due_date: 2.days.ago.to_date, actual_gc_due_date: nil, job_id: Job.second.id, department_id: Department.second.id, phase: "O", cost: '02', cost_type: 'L', notes: "None", crew_size: 5)
Scope.create(description: "Create Scaffolding", extra: false, estimated_hours: 40, hours: 35, value: 1500, estimated_gc_due_date: 3.weeks.ago.to_date, actual_gc_due_date: 18.days.ago.to_date, job_id: Job.second.id, department_id: Department.first.id, phase: "O", cost: '03', cost_type: 'L', notes: "Should be quick", crew_size: 2)
WorkDay.create(day: 1.day.ago.to_date, job_id: Job.first.id, employee_id: Employee.first.id)
WorkDay.create(day: 3.days.ago.to_date, job_id: Job.second.id, employee_id: Employee.second.id)
ScopeTime.create(week: Date.today-Date.today.wday+6, completion_rate: 80, scope_id: Scope.first.id)
ScopeTime.create(week: Date.today-Date.today.wday+6-7, completion_rate: 50, scope_id: Scope.second.id)
ScopeTime.create(week: Date.today-Date.today.wday+6, completion_rate: 100, scope_id: Scope.fourth.id)
#User.create(first_name: "Dylan", last_name: "Schwartz", email: "admin@example.com", password: "secret", role: "Administrator", phone: "4121111111", active: true)
