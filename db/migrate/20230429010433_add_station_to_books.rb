class AddStationToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :near_station, :string
  end
end
