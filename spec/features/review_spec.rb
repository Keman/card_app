require "rails_helper"
require "support/login_helper"

describe "review card process" do
  let!(:user) { create(:user, email: "u@mail.com", password: "123") }
  let!(:deck_1) { create(:deck, user: user) }
  let!(:deck_2) { create(:deck, user: user) }
  let!(:card_1) { create(:card, translated_text: "Тест", user: user, deck: deck_1) }
  let!(:card_2) { create(:card, translated_text: "Abrakadabra", user: user, deck: deck_2) }

  before(:each) do
    login("u@mail.com", "123")
    card_1.update_attributes(review_date: Time.now.utc)
    card_2.update_attributes(review_date: Time.now.utc)
    Deck.make_main(deck_1.id)
  end

  it "should show positive flash message (if it need)" do
    visit new_review_path
    fill_in "review_version_of_translation", with: "Тест"
    click_button "Проверить!"
    expect(page).to have_content "Правильно :)"
  end

  it "should show warning flash message (if it need)" do
    visit new_review_path
    fill_in "review_version_of_translation", with: "Тост"
    click_button "Проверить!"
    expect(page).to have_content "Опечатка?"
  end

  it "should show negative flash message (if it need)" do
    visit new_review_path
    fill_in "review_version_of_translation", with: "Abrakadabra"
    click_button "Проверить!"
    expect(page).to have_content "Неправильно :("
  end

  it "should show card for review only from main deck (if it selected)" do
    visit new_review_path
    fill_in "review_version_of_translation", with: "Тест"
    click_button "Проверить!"
    expect(page).to have_content "Правильно :)"
  end

  it "should't show card for review from common deck if selected main" do
    visit new_review_path
    fill_in "review_version_of_translation", with: "Abrakadabra"
    click_button "Проверить!"
    expect(page).to have_content "Неправильно :("
  end

  it "should show picture (if it present))" do
    card_1.update_attributes(picture: File.open("#{Rails.root}/spec/support/ruby.png"))
    visit new_review_path
    expect(page).to have_selector("img")
  end
end
