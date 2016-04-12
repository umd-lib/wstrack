class CreateLocationMaps < ActiveRecord::Migration
  def change
    create_table :location_maps do |t|
      t.string :code
      t.string :value
      t.string :regex

      t.timestamps null: false
    end
  end
end
