require "rails_helper"

describe Card do
  context "#check_translation" do
    let(:card) { create(:card, original_text: "Test", translated_text: "Тест") }

    it "should correct verify compliance translations" do
      expect(card.check_translation("тЕсТ")).to eq(true)
    end

    it "should not pass incorrect translations" do
      expect(card.check_translation("Текст")).to eq(false)
    end
  end

  describe "use freezing time" do
    before do
      Timecop.freeze
    end

    after do
      Timecop.return
    end

    it "should set right default review date" do
      card = Card.create(original_text: "Test", translated_text: "Тест", user_id: 0)
      expect(card.review_date).to eq(Time.now + 3.days)
    end
  end
end
