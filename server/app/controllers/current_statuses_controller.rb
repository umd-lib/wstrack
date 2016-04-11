class CurrentStatusesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update_status]
  before_action :set_current_status, only: [:show, :edit, :update, :destroy]

  # GET /current_statuses
  # GET /current_statuses.json
  def index
    @current_statuses = CurrentStatus.paginate(page: params[:page], per_page: 10)
  end

  # GET /current_statuses/1
  # GET /current_statuses/1.json
  def show
  end

  # GET /current_statuses/new
  def new
    @current_status = CurrentStatus.new
  end

  # GET /current_statuses/1/edit
  def edit
  end

  # POST /current_statuses
  # POST /current_statuses.json
  def create
    @current_status = CurrentStatus.new(current_status_params)

    respond_to do |format|
      if @current_status.save
        format.html { redirect_to @current_status, notice: 'Current status was successfully created.' }
        format.json { render :show, status: :created, location: @current_status }
      else
        format.html { render :new }
        format.json { render json: @current_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /current_statuses/1
  # PATCH/PUT /current_statuses/1.json
  def update
    respond_to do |format|
      if @current_status.update(current_status_params)
        format.html { redirect_to @current_status, notice: 'Current status was successfully updated.' }
        format.json { render :show, status: :ok, location: @current_status }
      else
        format.html { render :edit }
        format.json { render json: @current_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_statuses/1
  # DELETE /current_statuses/1.json
  def destroy
    @current_status.destroy
    respond_to do |format|
      format.html { redirect_to current_statuses_url, notice: 'Current status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def statuses
    @current_statuses = CurrentStatus.paginate(page: params[:page], per_page: 10)
  end

  def update_status
    current_status = CurrentStatus.find_by(workstation_name: params[:workstation_name])
    if current_status.nil?
      current_status = CurrentStatus.new(workstation_name: params[:workstation_name])
    else
      current_status.update_values(status_params)
    end
    render nothing: true, status: current_status.save ? 200 : 400
  end

  private

    def status_params
      s_params = params.permit(:workstation_name, :status, :guest_flag, :os, :user_hash)
      # TO BE UPDATED (Check :user_hash to match libguest user and set this flag accordingly.)
      s_params[:guest_flag] = false
      s_params
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_current_status
      @current_status = CurrentStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def current_status_params
      params.require(:current_status).permit(:workstation_name, :status, :os, :user_hash, :guest_flag)
    end
end
