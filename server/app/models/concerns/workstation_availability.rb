# This module contains the methods to help generate location based workstation avaialability 
require 'active_support/concern'

module WorkstationAvailability
  extend ActiveSupport::Concern

  included do
    scope :disabled, -> { where(disabled: true) }
  end

  class_methods do
    # Get counts of available and total workstations by location.
    # Returns an array of hashes.
    # Each containing: location name, available pc count, total pc count, available mac count, total mac count
    def get_workstation_availability
      workstation_availability = []
      LocationMap.all.each do |location_map|
        total_pc = CurrentStatus.select(:id).where(location_map_id: location_map.id,
                                                   workstation_type: CurrentStatus::PC).count
        avail_pc = CurrentStatus.select(:id).where(location_map_id: location_map.id, status: CurrentStatus::LOGOUT,
                                                   workstation_type: CurrentStatus::PC).count
        total_mac = CurrentStatus.select(:id).where(location_map_id: location_map.id,
                                                    workstation_type: CurrentStatus::MAC).count
        avail_mac = CurrentStatus.select(:id).where(location_map_id: location_map.id, status: CurrentStatus::LOGOUT,
                                                    workstation_type: CurrentStatus::MAC).count
        workstation_availability.push({location_name: location_map.value, available_pc: avail_pc, total_pc: total_pc,
                                                    available_mac: avail_mac, total_mac: total_mac})
      end
      workstation_availability
    end
  end
end