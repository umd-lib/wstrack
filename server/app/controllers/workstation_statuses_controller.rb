# frozen_string_literal: true

class WorkstationStatusesController < ApplicationController
  before_action :set_workstation_status, only: %i[show edit update destroy]

  # GET /workstation_statuses or /workstation_statuses.json
  def index
    @workstation_statuses = WorkstationStatus.all
  end

  # GET /workstation_statuses/1 or /workstation_statuses/1.json
  def show; end

  # GET /workstation_statuses/new
  def new
    @workstation_status = WorkstationStatus.new
  end

  # GET /workstation_statuses/1/edit
  def edit; end

  # POST /workstation_statuses or /workstation_statuses.json
  def create # rubocop:disable Metrics/MethodLength
    @workstation_status = WorkstationStatus.new(workstation_status_params)

    respond_to do |format|
      if @workstation_status.save
        format.html do
          redirect_to workstation_status_url(@workstation_status),
                      notice: 'Workstation status was successfully created.'
        end
        format.json { render :show, status: :created, location: @workstation_status }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workstation_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workstation_statuses/1 or /workstation_statuses/1.json
  def update # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      if @workstation_status.update(workstation_status_params)
        format.html do
          redirect_to workstation_status_url(@workstation_status),
                      notice: 'Workstation status was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @workstation_status }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workstation_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workstation_statuses/1 or /workstation_statuses/1.json
  def destroy
    @workstation_status.destroy

    respond_to do |format|
      format.html { redirect_to workstation_statuses_url, notice: 'Workstation status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_workstation_status
      @workstation_status = WorkstationStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workstation_status_params
      params.require(:workstation_status).permit(:workstation_name, :workstation_type, :os, :user_hash, :status,
                                                 :guest_flag)
    end
end
