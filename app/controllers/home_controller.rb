class HomeController < ApplicationController
    authorize_resource :class => false
    def home
    end
    
    def overview
    end
    
    def projection
        session[:dep1] = nil
        session[:reduce] = 10
        projection_boiler_plate
    end
    
    #Projection Page Actions
    def reduce
        reduce = params[:reduce].to_i
        unless reduce.nil? || reduce < 0 || reduce > 100
            session[:reduce] = params[:reduce].to_i
        end
        projection_boiler_plate
        ajax_respond
    end
    
    def change_dep_proj
        session[:dep1] = params[:dep]
        projection_boiler_plate
        ajax_respond
    end
    
    #rest is for scheduling page
    def scheduling
        session[:dep] = nil
        session[:emps] = []
        session[:wbeg] = Date.today - Date.today.wday + 1 #beginning of this week
        session[:j_scopes] = nil
        scheduling_boiler_plate
    end
    
    def week_before
        session[:wbeg] = session[:wbeg].to_date - 7 #move back a week
        scheduling_boiler_plate
        ajax_respond
    end
    
    def week_after
        session[:wbeg] = session[:wbeg].to_date + 7 #move forward a week
        scheduling_boiler_plate
        ajax_respond
    end
    
    def change_dep
        session[:dep] = params[:dep]
        scheduling_boiler_plate
        ajax_respond
    end
    
    def select_emp
        session[:emps].append(params[:emp])
        scheduling_boiler_plate
        ajax_respond
    end
    
    def clear_emp
        session[:emps] = []
        scheduling_boiler_plate
        ajax_respond
    end
    
    def add_workday
        if !session[:emps].empty?
            session[:emps].each do |emp|
                #watch out, for some reason hidden_field_tag submitted these as strings
                day, job_id = params[:day].to_i, params[:job].to_i
                new_wd = WorkDay.new
                new_wd.job_id = job_id
                new_wd.day = (session[:wbeg].to_date + day).to_datetime
                new_wd.employee_id = emp
                new_wd.save!
            end
            scheduling_boiler_plate
            ajax_respond
        else
            scheduling_boiler_plate
            respond_to do |format|
                format.html { redirect_to scheduling_path, notice: "You should not see this message, contact admin if you do."}
                format.js #{  flash[:notice] = "You need to select employees to assign them to jobs." }
            end
        end
    end
    
    def remove_workday
        @workday = WorkDay.find(params[:workday])
        @workday.destroy
        scheduling_boiler_plate
        ajax_respond
    end
    
    def get_job_scopes
        session[:j_scopes] = Job.find(params[:job]).scopes
        scheduling_boiler_plate
        ajax_respond
    end
    
    private
    def scheduling_boiler_plate
        @selected_emps = []
        session[:emps].each do |emp|
            @selected_emps.append(Employee.find(emp))
        end
        @employees = Employee.all.where.not(id: @selected_emps) #disallow double picking employees
        @wbeg = session[:wbeg].to_date
        @departments = Department.all
        @work_days = WorkDay.all
        @job_scopes = session[:j_scopes]
        if session[:dep].nil?
            @jobs = Job.active_jobs
        else
            @jobs = Job.active_jobs.for_department(session[:dep])
            @curr_dep = Department.find(session[:dep])
        end
    end
    
    def projection_boiler_plate
        @departments = Department.all
        @reduce = session[:reduce]
        if session[:dep1].nil?
            @jobs = Job.incomplete_jobs
        else
            @jobs = Job.incomplete_jobs.for_department(session[:dep1])
            @curr_dep = Department.find(session[:dep1])
        end
    end
    
    def ajax_respond
        respond_to do |format|
            format.html { redirect_to home_path notice: "You should not see this message, contact admin if you do."}
            format.js
        end
    end
    
end