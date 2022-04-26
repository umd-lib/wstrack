# frozen_string_literal: true

class WorkstationAvailabilityController < ApplicationController
  skip_before_action :authenticate, only: %i[index]

  def index
    @availability_list = WorkstationStatus.workstation_availability_list
  end
end
