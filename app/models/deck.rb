class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  validates :user_id, presence: true

  def self.of_user(id)
    where(user_id: id)
  end

  def self.make_main(id)
    @deck = Deck.find(id)
    if find_main.present?
      find_main.update_attributes(main: false)
    end
    @deck.update_attributes(main: true)
  end

  def self.make_common(id)
    deck = Deck.find(id)
    deck.update_attributes(main: false)
  end

  def self.find_main
    find_by(user: @deck.user, main: true)
  end
end
