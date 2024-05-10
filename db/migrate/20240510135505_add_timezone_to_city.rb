class AddTimezoneToCity < ActiveRecord::Migration[7.1]
  def change
    add_column :cities, :timezone, :string
  end
end
