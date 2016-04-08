# CurrentStatus model defines the fields and validation for the tracking the current status of workstatons.
# For each tracking update from clients, either an existing CurrentStatus record that matches the workstation_name
# will be updated, or a new CurrentStatus record will be created.
class CurrentStatus < ActiveRecord::Base
  before_save { workstation_name.upcase! }
  before_save { status.downcase! }
  default_scope -> { order(updated_at: :desc) }
  VALID_WORKSTATION_NAME_REGEX = /\ALIBRWK(MCK|LMS|ARC|ART|EPL|CHM|MDR|PAL)[PM][1-7B]F(1|3|7)?.*\z/
  validates :workstation_name, presence: true, format: { with: VALID_WORKSTATION_NAME_REGEX },
                               uniqueness: { case_sensitive: false }
  validates :status, inclusion: { in: %w(login logout) }
  validates :os, presence: true
  validates :user_hash, presence: true
  validates :guest_flag, inclusion: { in: [true, false] }

  def update_values(status_hash)
    self.status = status_hash[:status]
    self.os = status_hash[:status]
    self.user_hash = status_hash[:user_hash]
    self.guest_flag = status_hash[:guest_flag]
  end
end
