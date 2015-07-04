class Card < ActiveRecord::Base
  before_validation :rev_time, on: [ :create, :update ]
  validates :original_text, :translated_text, :review_date, presence: true
  validate :equality_check

  def equality_check
    if (original_text.capitalize == translated_text.capitalize)
      errors.add(:original_text, "original and translated text can't be equal")
    end
  end

  protected
    def rev_time
      self.review_date = Time.now + 3.days
    end
end
