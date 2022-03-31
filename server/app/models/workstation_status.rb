# frozen_string_literal: true

# WorkstationStatus
class WorkstationStatus < ApplicationRecord
  PATTERN_MAC = /(?i)^LIBRWK(MCK|LMS|ARC|ART|EPL|CHM|MDR|PAL)M[1-7B]F(1|3|7)?.*$/.freeze
  PATTERN_PC = /(?i)^LIBRWK(MCK|LMS|ARC|ART|EPL|CHM|MDR|PAL)P[1-7B]F(1|3|7)?.*$/.freeze
  VALID_WORKSTATION_NAME_REGEX = /\ALIBRWK(MCK|LMS|ARC|ART|EPL|CHM|MDR|PAL)[PM][1-7B]F(1|3|7)?.*\z/.freeze

  MAC = 'MAC'
  PC = 'PC'
  LOGIN = 'login'
  LOGOUT = 'logout'

  before_save { workstation_name.upcase! }
  before_save { status.downcase! }
  before_save { set_workstation_type }

  default_scope -> { order(updated_at: :desc) }

  validates :workstation_name, presence: true, format: { with: VALID_WORKSTATION_NAME_REGEX },
                               uniqueness: { case_sensitive: false }
  validates :status, inclusion: { in: %w[login logout] }
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
end
