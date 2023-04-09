class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :book_view_counts,dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :score,presence:true

  scope :latest, -> {order(created_at: :desc)}
  scope :score_count, -> {order(score: :desc)}

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_daysago, -> (days) { where(created_at: days.day.ago.all_day) }

   scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
