# frozen_string_literal: true

# Location contains the mapping of the workstation_name to their corresponding location in the library.
class Location < ApplicationRecord
  has_many(
    :workstation_status,
    class_name: 'WorkstationStatus',
    inverse_of: :location,
    dependent: nil
  )

  default_scope -> { order(name: :asc) }

  validates :code, presence: true
  validates :name, presence: true
  validates :regex, presence: true, uniqueness: true
  validate :valid_regex?

  # Class methods
  class << self
    # Find if any of the location regex matches the given workstation_name.
    # Return Location id if match found, nil if no match found.
    def find_matching_location(workstation_name)
      all.find_each do |location|
        return location.id if (Regexp.new location.regex).match(workstation_name)
      end
      nil # Return nil if no match found
    end
  end

  private

    def valid_regex?
      Regexp.new regex
    rescue StandardError => e
      errors.add(:regex, "invalid: #{e.message}")
    end
end
