require "rails_helper"
require "support/login_helper"

describe "user process" do
  let!(:user_1) { create(:user, email: "user_1@mail.com", password: "123") }
  let!(:user_2) { create(:user, email: "user_2@mail.com", password: "123") }
  let!(:card) { create(:card, translated_text: "Тест", user_id: user_1.id) }

  it "should login after registration user" do
    visit root_path
    click_link I18n.t "nav.sign_up"
    fill_in "user_email", with: "test@mail.com"
    fill_in "user_password", with: "qwerty"
    fill_in "user_password_confirmation", with: "qwerty"
    click_button I18n.t "default.submit"
    expect(page).to have_content I18n.t "user.create"
  end

  it "should show card only if user is owner" do
    login("user_1@mail.com", "123")
    visit cards_path
    expect(page).to have_content "Тест"
  end

  it "shouldn't show card if user is no owner" do
    login("user_2@mail.com", "123")
    visit cards_path
    expect(page).not_to have_content "Тест"
  end

  it "should change card only if user is owner" do
    login("user_1@mail.com", "123")
    visit edit_card_path(card)
    expect(page).to have_content I18n.t "card.edit"
  end

  it "shouldn't change card if user is no owner" do
    login("user_2@mail.com", "123")
    visit edit_card_path(card)
    expect(page).to have_content I18n.t "default.auth.wrong_user"
  end
end
