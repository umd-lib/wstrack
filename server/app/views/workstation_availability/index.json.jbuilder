# frozen_string_literal: true

json.array! @availability_list, partial: 'workstation_availability/workstation_availability',
                                as: :workstation_availability
