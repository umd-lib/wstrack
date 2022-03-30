json.extract! workstation_status, :id, :workstation_name, :workstation_type, :os, :user_hash, :status, :guest_flag, :created_at, :updated_at
json.url workstation_status_url(workstation_status, format: :json)
