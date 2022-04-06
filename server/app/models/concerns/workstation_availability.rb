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
    def workstation_availability_list
      workstation_availability = []
      Location.find_each do |location|
        total_pc = pc_count_by_location(location.id)
        avail_pc = pc_count_by_location(location.id, status: WorkstationStatus::LOGOUT)
        total_mac = mac_count_by_location(location.id)
        avail_mac = mac_count_by_location(location.id, status: WorkstationStatus::LOGOUT)
        workstation_availability.push(location_name: location.name, available_pc: avail_pc, total_pc: total_pc,
                                      available_mac: avail_mac, total_mac: total_mac)
      end
      workstation_availability
    end

    def pc_count_by_location(location_id, options = {})
      options[:workstation_type] = WorkstationStatus::PC
      count_by_location(location_id, options)
    end

    def mac_count_by_location(location_id, options = {})
      options[:workstation_type] = WorkstationStatus::MAC
      count_by_location(location_id, options)
    end

    def count_by_location(location_id, options = {})
      options[:location_id] = location_id
      WorkstationStatus.select(:id).where(options).count
    end
  end
end
