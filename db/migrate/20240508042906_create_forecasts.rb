class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.integer :city_id
      t.string :codes
      t.string :min_temps
      t.string :max_temps
      t.string :sunrise_times
      t.string :sunset_times

      t.timestamps
    end
  end
end
