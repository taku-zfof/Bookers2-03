class ChangeDataTitleToArticle2 < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :score, :float
  end
end
