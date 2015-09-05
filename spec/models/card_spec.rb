require "rails_helper"

describe Card do
  context "#check_translation" do
    let(:test_card) { Card.create!(original_text: "Mom wash frame", translated_text: "Мама мыла раму") }

    it "should correct verify compliance translations" do
      expect(test_card.check_translation("мАмА  МыЛА   РамУ")).to eq(true)
    end

    it "should not pass incorrect translations" do
      expect(test_card.check_translation("Мать протирала окно")).to eq(false)
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
      test_card = Card.create!(original_text: "A", translated_text: "B")

      expect(test_card.review_date).to eq(Time.now + 3.days)
    end
  end
end
