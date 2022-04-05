# frozen_string_literal: true

# WorkstationStatus
class WorkstationStatus < ApplicationRecord
  MAC = 'MAC'
  PC = 'PC'

  def self.statuses
    %w[login logout]
  end

  before_save { workstation_name.upcase! }
  before_save { status.downcase! }
  before_save { set_location_id }
  before_save { set_workstation_type }

  default_scope -> { order(updated_at: :desc) }

  belongs_to(
    :location,
    class_name: 'Location',
    optional: true,
    inverse_of: :workstation_status
  )

  validates :workstation_name, presence: true, uniqueness: { case_sensitive: false }
  validates :status, inclusion: { in: statuses }
  validates :os, presence: true
  validates :user_hash, presence: true
  validates :guest_flag, inclusion: { in: [true, false] }

  attr_accessor :validation_messages

  private

    def update_values(status_hash)
      self.status = status_hash[:status]
      self.os = status_hash[:os]
      self.user_hash = status_hash[:user_hash]
      self.guest_flag = status_hash[:guest_flag]
    end

    def set_workstation_type # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      self.validation_messages ||= []
      unless location_id
        self.validation_messages.push('Workstation type cannot be determined without location!')
        return
      end

      unless location.regex.include?('[PM]')
        message = 'The matching location regex did not include "[PM]": workstation type could not be determined!'
        self.validation_messages.push(message)
        return
      end

      if Regexp.new(location.regex.sub('[PM]', 'M')).match(workstation_name)
        self.workstation_type = MAC
      elsif Regexp.new(location.regex.sub('[PM]', 'P')).match(workstation_name)
        self.workstation_type = PC
      end
    end

    def set_location_id
      self.location_id = Location.find_matching_location(workstation_name)
      self.validation_messages ||= []
      self.validation_messages.push('The workstation name did not match any location!') unless location_id
    end
end
