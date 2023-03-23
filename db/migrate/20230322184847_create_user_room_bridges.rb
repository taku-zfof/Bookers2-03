class CreateUserRoomBridges < ActiveRecord::Migration[6.1]
  def change
    create_table :user_room_bridges do |t|
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
