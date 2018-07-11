class ScopeTimesController < ApplicationController
    before_action :set_scope_time, only: [:destroy]
    
    def index
        @scope_times = ScopeTime.all
    end
    
    def new
        @scope_time = ScopeTime.new
    end
    
    def create
        @scope_time = ScopeTime.new(scope_time_params)
        
        respond_to do |format|
            if @scope_time.save
                format.html { redirect_to scopes_path(@scope_time.scope), notice: 'Scope time was successfully created.' }
                @scope = @scope_time.scope
                @scope_times = ScopeTime.all
                format.js
            else
                format.html { redirect_to scopes_path(@scope_time.scope), notice: 'Scope time was not created, error occurred.' }
                format.js
            end
        end
    end
    
    def destroy
        @scope_time.destroy
        respond_to do |format|
          format.html { redirect_to scope_times, notice: 'Scope Time was successfully destroyed.' }
          format.json { head :no_content }
        end
    end
    
    private
        def set_scope_time
          @scope_time = ScopeTime.find(params[:id])
        end
    
        def scope_time_params
            params.require(:scope_time).permit(:scope_id, :week, :hours, :completion_rate)
        end
end