class ScopesController < ApplicationController
    def new
        @scope_time = ScopeTime.new
    end
    
    def create
        @scope_time = Scope.new(scope_time_params)
        
        respond_to do |format|
            if @scope_time.save
                format.html { redirect_to scopes_path(@scope_time.scope), notice: 'Scope time was successfully created.' }
                @scope = @scope_time.scope
                @scope_times = @scope.scope_times
                format.js
            else
                format.html { redirect_to scopes_path(@scope_time.scope), notice: 'Scope time was not created, error occurred.' }
            end
        end
    end
    
    private
      def scope_time_params
        params.require(:scope_time).permit(:scope_id, :week, :hours, :completion_rate)
      end
end