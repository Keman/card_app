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

  it "should set right default review date" do
    expect(card.review_date).to eq(Time.now.to_date + 3.days)
  end
end
