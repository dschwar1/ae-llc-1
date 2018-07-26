class HomeController < ApplicationController
    def home
    end
    
    def scheduling
        session[:dep] = nil
        session[:emps] = []
        session[:wbeg] = Date.today - Date.today.wday + 1 #beginning of this week
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
    
    #TO DO first make basic employee selector (probably should be a session variable)
    #keep track of job variable locally in view
    #keep track of date variable locally in view and with wbeg session var
    
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
        if session[:dep].nil?
            @jobs = Job.active_jobs
        else
            @jobs = Job.active_jobs.for_department(session[:dep])
            @curr_dep = Department.find(session[:dep])
        end
    end
    
    def ajax_respond
        respond_to do |format|
            format.html { redirect_to scheduling_path notice: "You should not see this message, contact admin if you do."}
            format.js
        end
    end
    
end