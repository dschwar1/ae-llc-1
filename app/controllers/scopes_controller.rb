class ScopesController < ApplicationController
  before_action :set_scope, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  # GET /scopes
  # GET /scopes.json
  def index
    #if params[estimated_gc_sort]
    #  @
    @scopes = Scope.all
    @jobs = Job.all
    session[:job_number] = nil
    session[:phase] = nil
    session[:cost] = nil
    session[:job_name] = nil
    session[:date_filter] = nil
    session[:start_date] = nil
    session[:end_date] = nil
    session[:passed_filter] = nil
    session[:incomplete_filter] = nil
    session[:missing_filter] = nil
  end
  
  def filter_date
    #check for not nil
    start_date, end_date, date_type = params[:start_date], params[:end_date], params[:date_type]
    if start_date and end_date and date_type
      #check for valid dates
      valid_input = check_dates_valid(start_date, end_date)
      print("\n---")
      print(start_date, end_date)
      print("---\n")
      if valid_input
        session[:date_filter] = date_type
        session[:scope_start_date] = start_date.to_date
        session[:scope_end_date] = end_date.to_date
      end
    end
    index_boiler_plate
    ajax_respond
  end
  
  def search
    if params[:search_action] == 'Job Number'
      session[:job_number] = params[:input]
    elsif params[:search_action] == 'Phase'
      session[:phase] = params[:input]
    elsif params[:search_action] == 'Cost'
      session[:cost] = params[:input]
    elsif params[:search_action] == 'Job Name'
      session[:job_name] = params[:input]
    end
    index_boiler_plate
    ajax_respond
  end
  
  def filter_misc
    if params[:commit] == 'Actual GC Due Date Passed'
      session[:passed_filter] = true
    elsif params[:commit] == 'Show Only Incomplete Scopes'
      session[:incomplete_filter] = true
    elsif params[:commit] == 'Show Scopes Missing Actual Due Dates'
      session[:missing_filter] = true
    end
    index_boiler_plate
    ajax_respond
  end
  
  def clear
    if params[:commit] == 'Clear Job Number'
      session[:job_number] = nil
    elsif params[:commit] == 'Clear Phase'
      session[:phase] = nil#params[:input]
    elsif params[:commit] == 'Clear Cost'
      session[:cost] = nil#params[:input]
    elsif params[:commit] == 'Clear Job Name'
      session[:job_name] = nil#params[:input]
    elsif params[:commit] == 'Clear Date Filter'
      session[:date_filter] = nil
      session[:scope_start_date] = nil
      session[:scope_end_date] = nil
    elsif params[:commit] == 'Clear passed due dates filter'
      session[:passed_filter] = nil
    elsif params[:commit] == 'Clear incomplete scopes filter'
      session[:incomplete_filter] = nil
    elsif params[:commit] == 'Clear missing due dates filter'
      session[:missing_filter] = nil
    end
    
    index_boiler_plate
    ajax_respond
  end

  # GET /scopes/1
  # GET /scopes/1.json
  def show
    @scope_times = @scope.scope_times
  end

  # GET /scopes/new
  def new
    @scope = Scope.new
  end

  # GET /scopes/1/edit
  def edit
  end

  # POST /scopes
  # POST /scopes.json
  def create
    @scope = Scope.new(scope_params)

    respond_to do |format|
      @scopes = Scope.all #for creating scopes on index page through ajax
      if @scope.save
        format.html { redirect_to @scope, notice: 'Scope was successfully created.' }
        format.json { render :show, status: :created, location: @scope }
        format.js
      else
        format.html { render :new }
        format.json { render json: @scope.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scopes/1
  # PATCH/PUT /scopes/1.json
  def update
    respond_to do |format|
      if @scope.update(scope_params)
        format.html { redirect_to @scope, notice: 'Scope was successfully updated.' }
        format.json { render :show, status: :ok, location: @scope }
      else
        format.html { render :edit }
        format.json { render json: @scope.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scopes/1
  # DELETE /scopes/1.json
  def destroy
    @scope.destroy
    respond_to do |format|
      format.html { redirect_to scopes_url, notice: 'Scope was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scope
      @scope = Scope.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scope_params
      params.require(:scope).permit(:description, :extra, :estimated_hours, :hours, :value, :estimated_gc_due_date, :actual_gc_due_date, :job_id, :department_id, :phase, :cost, :cost_type, :notes, :crew_size)
    end
    
    def index_boiler_plate
      @jobs = Job.all
      @scopes = Scope.all
      if session[:job_number]
        @jobs = @jobs.for_job_number(session[:job_number])
      end
      if session[:phase]
        @jobs = @jobs.joins(:scopes).for_scope_phase(session[:phase])
        @scopes = @scopes.for_phase(session[:phase])
      end
      if session[:cost]
        @jobs = @jobs.joins(:scopes).for_scope_cost(session[:cost])
        @scopes = @scopes.for_cost(session[:cost])
      end
      if session[:job_name]
        @jobs = @jobs.for_job_name(session[:job_name])
      end
      if session[:date_filter] == "Estimated"
        @jobs = @jobs.between_scope_estimated_dates(session[:scope_start_date], session[:scope_end_date])
        @scopes = @scopes.between_estimated_dates(session[:scope_start_date], session[:scope_end_date])
      elsif session[:date_filter] == "Actual"
        @jobs = @jobs.between_scope_actual_dates(session[:scope_start_date], session[:scope_end_date])
        @scopes = @scopes.between_actual_dates(session[:scope_start_date], session[:scope_end_date])
      end
      if session[:passed_filter]
        @jobs = @jobs.scope_actual_date_passed
        @scopes = @scopes.actual_date_passed
      end
      if session[:incomplete_filter]
        @jobs = @jobs.incomplete_jobs
        @scopes = @scopes.show_incomplete
      end
      if session[:missing_filter]
        @jobs = @jobs.scope_actual_date_nil
        @scopes = @scopes.actual_date_nil
      end
    end
    
    def ajax_respond
        respond_to do |format|
            format.html { redirect_to scopes_path notice: "You should not see this message, contact admin if you do."}
            format.js
        end
    end
    
    def check_dates_valid(first, second)
      d, m, y = first.split '/'
      d2, m2, y2 = second.split '/'
      valid_input = Date.valid_date? y.to_i, m.to_i, d.to_i
      valid_input2 = Date.valid_date? y2.to_i, m2.to_i, d2.to_i
      print(m2)
      print(valid_input)
      print(valid_input2)
      print((valid_input and valid_input2))
      return (valid_input and valid_input2)
    end
end
