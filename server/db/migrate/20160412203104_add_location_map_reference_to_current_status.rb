class AddLocationMapReferenceToCurrentStatus < ActiveRecord::Migration
  def change
    add_reference :current_statuses, :location_map, index: true, foreign_key: true
  end
end
