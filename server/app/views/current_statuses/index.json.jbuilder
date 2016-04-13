json.array!(@current_statuses) do |current_status|
  json.extract! current_status, :id, :workstation_name, :location, :status, :os, :user_hash, :guest_flag
  json.url current_status_url(current_status, format: :json)
end
