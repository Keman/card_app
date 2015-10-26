class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :cards
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true, email_format: { message: "has invalid format" }

  def self.notify_pending_cards
    User.where(id: Card.for_review.select(:user_id).group(:user_id)).find_each do |user|
      NotificationsMailer.pending_cards(user).deliver_now
    end
  end
end
