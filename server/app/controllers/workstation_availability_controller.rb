class WorkstationAvailabilityController < ApplicationController
  def index
    @availability_list = CurrentStatus.get_workstation_availability
  end
end
