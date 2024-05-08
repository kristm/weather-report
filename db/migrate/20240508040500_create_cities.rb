class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.float :long, precision: 2, null: false
      t.float :lat, precision: 2, null: false

      t.timestamps
    end
  end
end
