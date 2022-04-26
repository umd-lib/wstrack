# frozen_string_literal: true

json.array! @workstation_statuses, partial: 'workstation_statuses/workstation_status', as: :workstation_status
