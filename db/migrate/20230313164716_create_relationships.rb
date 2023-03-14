class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follow_suru_id
      t.integer :follow_sareru_id

      t.timestamps
    end
  end
end
