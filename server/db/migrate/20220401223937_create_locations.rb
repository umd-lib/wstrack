class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :code
      t.string :name
      t.string :regex, index: {unique: true}

      t.timestamps
    end
  end
end
