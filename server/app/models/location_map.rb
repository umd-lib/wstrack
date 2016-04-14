# Location Map contains the mapping of the workstation_name to their corresponding location in the library.
class LocationMap < ActiveRecord::Base
  has_many :current_status

  default_scope -> { order(value: :asc) }

  validates :code, presence: true
  validates :value, presence: true
  validates :regex, presence: true, uniqueness: true, verify_regexp: true

  class << self # Class methods
    # Find if any of the location map regex matches the given workstation_name.
    # Return LocationMap id if match found, nil if no match found.
    def find_matching_location(workstation_name)
      self.all.each do |location_map|
        if (Regexp.new location_map.regex[1..-2]).match(workstation_name)
          return location_map.id
          break
        end
      end
      nil # Return nil if no match found
    end
  end
end
