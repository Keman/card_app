require "rails_helper"

describe Card do
  context "#check_translation" do
    let(:c) do
      create(:card, original_text: "Test", translated_text: "Тест")
    end

    it "should correct verify compliance translations" do
      expect(c.check_translation("тЕсТ")).to eq(true)
    end

    it "should not pass incorrect translations" do
      expect(c.check_translation("Текст")).to eq(false)
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
      u = User.create
      c = Card.create(original_text: "Test", translated_text: "Тест", user_id: u.id)

      expect(c.review_date).to eq(Time.now + 3.days)
    end
  end
end
