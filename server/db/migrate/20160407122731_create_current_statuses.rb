class CreateCurrentStatuses < ActiveRecord::Migration
  def change
    create_table :current_statuses do |t|
      t.string :workstation_name
      t.string :status
      t.string :os
      t.string :user_hash
      t.boolean :guest_flag

      t.timestamps null: false
    end
  end
end
