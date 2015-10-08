require "rails_helper"

describe Card do
  context "#check_translation" do
    let!(:card) { create(:card, original_text: "Test", translated_text: "Тест") }

    it "should correct verify compliance translations" do
      expect(card.check_translation("тЕсТ")).to eq(true)
    end

    it "should not pass incorrect translations" do
      expect(card.check_translation("Текст")).to eq(false)
    end
  end

  describe "use freezing time" do
    let!(:card) { create(:card) }

    it "should set right default review date" do
      expect(card.review_date.round(0)).to eq(Time.now.utc.round(0) + 3.days)
    end
  end
end
