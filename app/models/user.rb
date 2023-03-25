class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :book_view_counts, dependent: :destroy
  has_one_attached :profile_image

  has_many :follow_suru ,class_name: "Relationship", foreign_key: "follow_suru_id", dependent: :destroy
  has_many :followings, through: :follow_suru, source: :follow_sareru
  has_many :follow_sareru, class_name: "Relationship", foreign_key: "follow_sareru_id", dependent: :destroy
  has_many :followers, through: :follow_sareru, source: :follow_suru

  has_many :messages, dependent: :destroy
  has_many :user_room_bridges, dependent: :destroy

 def is_followed_by?(user)
   follow_sareru.find_by(follow_suru_id: user.id).present?
 end


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
