require "rails_helper"

RSpec.describe Card, type: :model do
  it "should correct verify compliance translations" do
    test_card = Card.create!(original_text: "Mom wash frame", translated_text: "Мама мыла раму")

    expect(test_card.check_translation("мАмА  МыЛА   РамУ")).to eq(true)
  end

  it "should correct verify compliance translations" do
    test_card = Card.create!(original_text: "Mom wash frame", translated_text: "Мама мыла раму")

    expect(test_card.check_translation("Мать протирала окно")).to eq(false)
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
      r_date = Time.now + 3.days

      expect(test_card.review_date == r_date).to eq(true)
    end
  end
end
