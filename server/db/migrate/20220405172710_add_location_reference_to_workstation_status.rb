class AddLocationReferenceToWorkstationStatus < ActiveRecord::Migration[6.1]
  def change
    add_reference :workstation_statuses, :location, index: true, foreign_key: true
  end
end
