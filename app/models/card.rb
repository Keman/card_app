class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck

  before_validation :set_default_review_date, on: [:create]
  validates :user_id, :deck_id, :original_text, :translated_text, :review_date, presence: true
  validate :equality_check

  has_attached_file :picture, styles: { original: "360x360#" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :picture, less_than: 1.megabytes

  scope :for_review, -> { where("review_date <= ?", Time.now.utc).order ("random()") }

  def self.of_user(id)
    where(user_id: id)
  end

  def self.of_deck(id)
    where(deck_id: id)
  end

  def check_translation(version_of_translation)
    if prepare_word(version_of_translation) == prepare_word(translated_text)
      self.review_date = Time.now.utc.to_date + 5.days
      save
      true
    else
      false
    end
  end

  private

  def set_default_review_date
    self.review_date = Time.now.utc.to_date
  end

  def equality_check
    if prepare_word(original_text) == prepare_word(translated_text)
      errors.add(:original_text, "original and translated text can't be equal")
    end
  end

  def prepare_word(text)
    text.squish.mb_chars.capitalize
  end
end
