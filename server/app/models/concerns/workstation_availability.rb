require 'active_support/concern'

# This module contains the methods to help generate location based workstation avaialability.
module WorkstationAvailability
  extend ActiveSupport::Concern

  included do
    scope :disabled, -> { where(disabled: true) }
  end

  class_methods do
    # Get counts of available and total workstations by location.
    # Returns an array of hashes.
    # Each containing: location name, available pc count, total pc count, available mac count, total mac count
    def workstation_availability_list
      workstation_availability = []
      LocationMap.find_each do |location_map|
        total_pc = pc_count_by_location(location_map.id)
        avail_pc = pc_count_by_location(location_map.id, status: CurrentStatus::LOGOUT)
        total_mac = mac_count_by_location(location_map.id)
        avail_mac = mac_count_by_location(location_map.id, status: CurrentStatus::LOGOUT)
        workstation_availability.push(location_name: location_map.value, available_pc: avail_pc, total_pc: total_pc,
                                      available_mac: avail_mac, total_mac: total_mac)
      end
      workstation_availability
    end

    def pc_count_by_location(location_id, options = {})
      options[:workstation_type] = CurrentStatus::PC
      count_by_location(location_id, options)
    end

    def mac_count_by_location(location_id, options = {})
      options[:workstation_type] = CurrentStatus::MAC
      count_by_location(location_id, options)
    end

    def count_by_location(location_id, options = {})
      options[:location_map_id] = location_id
      CurrentStatus.select(:id).where(options).count
    end
  end
end
