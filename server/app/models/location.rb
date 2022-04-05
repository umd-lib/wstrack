# frozen_string_literal: true

# Location Map contains the mapping of the workstation_name to their corresponding location in the library.
class Location < ApplicationRecord
  validates :code, presence: true
  validates :name, presence: true
  validates :regex, presence: true, uniqueness: true
  validate :valid_regex?

  private

    def valid_regex?
      Regexp.new regex
    rescue StandardError => e
      errors.add(:regex, "invalid: #{e.message}")
    end
end
