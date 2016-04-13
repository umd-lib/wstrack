# Location Map contains the mapping of the workstation_name to their corresponding location in the library.
class LocationMap < ActiveRecord::Base
  validates :code, presence: true
  validates :value, presence: true
  validates :regex, presence: true, uniqueness: true, verify_regexp: true
end
