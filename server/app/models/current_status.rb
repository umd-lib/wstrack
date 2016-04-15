# CurrentStatus model defines the fields and validation for the tracking the current status of workstatons.
# For each tracking update from clients, either an existing CurrentStatus record that matches the workstation_name
# will be updated, or a new CurrentStatus record will be created.
class CurrentStatus < ActiveRecord::Base
  include WorkstationAvailability

  PATTERN_MAC = /(?i)^LIBRWK(MCK|LMS|ARC|ART|EPL|CHM|MDR|PAL)M[1-7B]F(1|3|7)?.*$/
  PATTERN_PC = /(?i)^LIBRWK(MCK|LMS|ARC|ART|EPL|CHM|MDR|PAL)P[1-7B]F(1|3|7)?.*$/
  VALID_WORKSTATION_NAME_REGEX = /\ALIBRWK(MCK|LMS|ARC|ART|EPL|CHM|MDR|PAL)[PM][1-7B]F(1|3|7)?.*\z/

  MAC = 'MAC'.freeze
  PC = 'PC'.freeze
  LOGIN = 'login'.freeze
  LOGOUT = 'logout'.freeze

  before_save { workstation_name.upcase! }
  before_save { status.downcase! }
  before_save { set_workstation_type }
  before_save { set_location_map_id }

  default_scope -> { order(updated_at: :desc) }

  has_one :location_map

  validates :workstation_name, presence: true, format: { with: VALID_WORKSTATION_NAME_REGEX },
                               uniqueness: { case_sensitive: false }
  validates :status, inclusion: { in: %w(login logout) }
  validates :os, presence: true
  validates :user_hash, presence: true
  validates :guest_flag, inclusion: { in: [true, false] }

  def update_values(status_hash)
    self.status = status_hash[:status]
    self.os = status_hash[:os]
    self.user_hash = status_hash[:user_hash]
    self.guest_flag = status_hash[:guest_flag]
  end

  def set_workstation_type
    if PATTERN_MAC.match(workstation_name)
      self.workstation_type = MAC
    elsif PATTERN_PC.match(workstation_name)
      self.workstation_type = PC
    end
  end

  def set_location_map_id
    self.location_map_id = LocationMap.find_matching_location(workstation_name)
  end

  # Get the location name value for the current status record.
  def location
    unless location_map_id.nil?
      location_map = LocationMap.find_by(id: location_map_id)
      if location_map.nil?
        set_location_map_id # Reset location_map_id, as the previous id does not exist in LocationMap anymore.
        location_map = LocationMap.find_by(id: location_map_id)
      end
      location_map.nil? ? nil : location_map.value
    end
  end
end
