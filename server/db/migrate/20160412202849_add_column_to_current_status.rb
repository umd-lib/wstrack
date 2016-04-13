class AddColumnToCurrentStatus < ActiveRecord::Migration
  def change
    add_column :current_statuses, :workstation_type, :string
  end
end
