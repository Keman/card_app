require "rails_helper"
require "support/login_helper"

describe "review card process" do
  let!(:user) { create(:user, email: "u@mail.com", password: "123") }
  let!(:card) { create(:card, translated_text: "Тест", user: user) }

  before(:each) do
    login("u@mail.com", "123")
    card.update_attributes(review_date: Time.now)
  end

  it "should show positive flash message (if it need)" do
    visit new_review_path
    fill_in "review_version_of_translation", with: "Тест"
    click_button "Проверить!"
    expect(page).to have_content "Правильно :)"
  end

  it "should show negative flash message (if it need)" do
    visit new_review_path
    fill_in "review_version_of_translation", with: "Abrakadabra"
    click_button "Проверить!"
    expect(page).to have_content "Неправильно :("
  end
end
