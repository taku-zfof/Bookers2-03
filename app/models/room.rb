class Room < ApplicationRecord
  
  has_many :user_room_bridges, dependent: :destroy
  has_many :messages, dependent: :destroy
  
end
