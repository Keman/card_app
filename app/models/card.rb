class Card < ActiveRecord::Base
  before_validation :set_default_review_date, on: [:create, :update]
  validates :original_text, :translated_text, :review_date, presence: true
  validate :equality_check

  scope :for_review, -> { where("review_date <= ?", Time.now).order ("random()")}

    def translation_check(version, translation, id)
      if prepare_word(version) == prepare_word(translation)
        Card.find(id).save
        true
      else
        false
      end
    end

  private
    def set_default_review_date
      self.review_date = Time.now + 3.days
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
