require "rails_helper"

describe Card do
  let!(:card) { create(:card, original_text: "Test", translated_text: "Тест") }

  context "#check_translation" do
    it "should correct verify compliance translations" do
      expect(card.check_translation("тЕсТ")).to eq(true)
    end

    it "should not pass incorrect translations" do
      expect(card.check_translation("Текст")).to eq(false)
    end
  end

  context "#manipulation with review_date" do
    it "should set right default review date" do
      expect(card.review_date).to eq(Time.now.utc.to_date)
    end

    it "should set right review_date(first lucky streak)" do
      card.check_translation("тЕсТ")
      expect(card.review_date).to eq(Time.now.utc.to_date + 1.day)
    end

    it "should set right review_date(second lucky streak)" do
      card.lucky_streak = 1
      card.check_translation("тЕсТ")
      expect(card.review_date).to eq(Time.now.utc.to_date + 3.days)
    end

    it "should set right review_date(third lucky streak)" do
      card.lucky_streak = 2
      card.check_translation("тЕсТ")
      expect(card.review_date).to eq(Time.now.utc.to_date + 7.days)
    end

    it "should set right review_date(fourth lucky streak)" do
      card.lucky_streak = 3
      card.check_translation("тЕсТ")
      expect(card.review_date).to eq(Time.now.utc.to_date + 14.days)
    end

    it "should set right review_date(fifth lucky streak)" do
      card.lucky_streak = 4
      card.check_translation("тЕсТ")
      expect(card.review_date).to eq(Time.now.utc.to_date + 30.days)
    end

    it "should set right review_date(third losing streak)" do
      card.lucky_streak = 2
      card.losing_streak = 2
      card.check_translation("Текст")
      expect(card.review_date).to eq(Time.now.utc.to_date + 1.days)
    end
  end
end
