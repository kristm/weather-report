class AddColumnToForecasts < ActiveRecord::Migration[7.1]
  def change
    add_column :forecasts, :days, :string
  end
end
