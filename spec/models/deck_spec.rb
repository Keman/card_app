require "rails_helper"

describe Deck do
  let!(:user)   { create(:user) }
  let!(:deck_1) { create(:deck, user: user) }
  let!(:deck_2) { create(:deck, user: user) }

  context "#control decks" do
    it "should make main deck" do
      expect(Deck.make_main(deck_1.id)).to eq(true)
    end

    it "should't make main other decks" do
      Deck.make_main(deck_1.id)
      expect(deck_2.main).to eq(false)
    end

    it "should make only one main" do
      Deck.make_main(deck_1.id)
      expect(Deck.make_main(deck_2.id)).to eq(true)
    end
  end
end
