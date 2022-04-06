class WorkstationAvailabilityController < ApplicationController
  def index
    @availability_list = WorkstationStatus.workstation_availability_list
  end
end
