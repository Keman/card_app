class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  before_validation :set_default_description, on: [:create]
  validates :user_id, presence: true

  def self.of_user(id)
    where(user_id: id)
  end

  def self.make_main(id)
    @deck = Deck.find(id)
    if find_main.present?
      old_main = find_main
      old_main.update_attributes(main: false)
    end
    @deck.update_attributes(main: true)
  end

  def self.make_common(id)
    deck = Deck.find(id)
    deck.update_attributes(main: false)
  end

  private

  def set_default_description
    if description.blank?
      self.description = "Новая колода"
    end
  end

  def self.find_main
    find_by(user_id: @deck.user_id, main: true)
  end
end
