class WorkDaysController < ApplicationController
    before_action :set_work_day, only: [:destroy]
    
    def new
        @work_day = WorkDay.new
    end
    
    def create
        @work_day = WorkDay.new(work_day_params)
        respond_to do |format|
            if @work_day.save
                format.html { redirect_to scheduling_path notice: "Work Day added successfully."}
                #add vars here for scheduling page
                format.js
            else
                format.html { redirect_to scheduling_path, notice: "Work Day could not be created. An Error has occurred." }
            end
        end
    end
    
    def destroy
        @work_day.destroy
        respond_to do |format|
            format.html { redirect_to scheduling_path notice: "Work Day destroyed successfully."}
        end
    end
    
    private
        def set_work_day
            @work_day = WorkDay.find(params[:id])
        end
        
        def work_day_params
            params.require(:work_day).permit(:job_id, :employee_id, :day)
        end
end