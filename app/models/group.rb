class Group < ApplicationRecord

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :events, dependent: :destroy

  has_one_attached :group_image

  validates :name, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: {maximum: 200}

 def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
 end

 def joined_in?(user)
   group_users=GroupUser.all
   group_users.find_by(user_id: user.id).present?
 end
end
