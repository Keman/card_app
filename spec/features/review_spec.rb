require "rails_helper"

describe "review card process" do
  it "should show right flash message" do
    create(:card)
    create(:card)

    visit new_review_path
    fill_in "review_version_of_translation", with: "Тест"
    click_button "Проверить!"
    expect(page).to have_content "Правильно :)"
  end
end
