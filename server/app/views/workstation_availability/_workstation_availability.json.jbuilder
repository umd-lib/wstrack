# frozen_string_literal: true

json.location workstation_availability[:location_name]
json.key workstation_availability[:location_code]
json.workstations do
  json.pc do
    json.total workstation_availability[:total_pc]
    json.available workstation_availability[:available_pc]
  end
  json.mac do
    json.total workstation_availability[:total_mac]
    json.available workstation_availability[:available_mac]
  end
end
