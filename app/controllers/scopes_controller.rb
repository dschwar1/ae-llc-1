class ScopesController < ApplicationController
  before_action :set_scope, only: [:show, :edit, :update, :destroy]

  # GET /scopes
  # GET /scopes.json
  def index
    @scopes = Scope.all
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
      if @scope.save
        format.html { redirect_to @scope, notice: 'Scope was successfully created.' }
        format.json { render :show, status: :created, location: @scope }
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
      params.require(:scope).permit(:description, :extra, :estimated_hours, :value, :estimated_gc_due_date, :actual_gc_due_date, :job_id, :department_id)
    end
end
