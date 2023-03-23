class CreateBookViewCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :book_view_counts do |t|
      t.integer :book_id

      t.timestamps
    end
  end
end
