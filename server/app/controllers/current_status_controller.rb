class CurrentStatusController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update_status]

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
end
