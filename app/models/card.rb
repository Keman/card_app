class Card < ActiveRecord::Base
  before_validation :set_default_review_date, on: :create
  validates :original_text, :translated_text, :review_date, presence: true
  validate :equality_check

  def equality_check
    if (original_text.squish.mb_chars.capitalize ==
        translated_text.squish.mb_chars.capitalize)
      errors.add(:original_text, "original and translated text can't be equal")
    end
  end

  protected
    def set_default_review_date
      self.review_date = Time.now + 3.days
    end
end
