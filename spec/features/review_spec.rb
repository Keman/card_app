require "rails_helper"

describe "review card process" do
  before(:each) do
    create(:card, translated_text: "Тест")
    create(:card, translated_text: "Тест")
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
