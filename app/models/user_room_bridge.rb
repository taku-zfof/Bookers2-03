class UserRoomBridge < ApplicationRecord
  belongs_to :user
  belongs_to :room
end
