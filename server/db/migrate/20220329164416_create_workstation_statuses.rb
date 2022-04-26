class CreateWorkstationStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :workstation_statuses do |t|
      t.string :workstation_name, index: {unique: true}
      t.string :workstation_type
      t.string :os
      t.string :user_hash
      t.string :status
      t.boolean :guest_flag

      t.timestamps
    end
  end
end
