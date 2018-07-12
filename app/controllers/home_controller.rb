class HomeController < ApplicationController
    def home
    end
    
    def scheduling
        session[:wbeg] = Date.today - Date.today.wday + 1 #beginning of this week
        @work_days = WorkDay.all
        @jobs = Job.all
        @wbeg = session[:wbeg] 
    end
    
    def week_before
        @work_days = WorkDay.all
        @jobs = Job.all
        @wbeg = session[:wbeg].to_date - 7 #shift back a week
        session[:wbeg] = session[:wbeg].to_date - 7
        respond_to do |format|
            format.html { redirect_to scheduling_path notice: "You should not see this message, contact admin if you do."}
            format.js
        end
    end
    
    def week_after
        @work_days = WorkDay.all
        @jobs = Job.all
        @wbeg = session[:wbeg].to_date + 7 #shift forward a week
        session[:wbeg] = session[:wbeg].to_date + 7
        respond_to do |format|
            format.html { redirect_to scheduling_path notice: "You should not see this message, contact admin if you do."}
            format.js
        end
    end
    
end