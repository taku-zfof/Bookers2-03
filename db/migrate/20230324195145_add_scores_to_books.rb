class AddScoresToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :score, :integer
  end
end
