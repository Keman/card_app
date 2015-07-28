class Card < ActiveRecord::Base
  before_validation :set_default_review_date, on: :create
  validates :original_text, :translated_text, :review_date, presence: true
  validate :equality_check

  protected
    def set_default_review_date
      self.review_date = Time.now + 3.days
    end

  private
    def equality_check
      if prepare_word(original_text) == prepare_word(translated_text)
        errors.add(:original_text, "original and translated text can't be equal")
      end
    end

    def prepare_word(text)
      text.squish.mb_chars.capitalize
    end
end
