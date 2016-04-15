class WorkstationAvailabilityController < ApplicationController
  def index
    @availability_list = CurrentStatus.workstation_availability_list
  end
end
