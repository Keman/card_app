require "rails_helper"
require "support/login_helper"

describe "user process" do
  let!(:user1) { create(:user, email: "u1@mail.com", password: "123") }
  let!(:user2) { create(:user, email: "u2@mail.com", password: "123") }
  let!(:card) { create(:card, translated_text: "Тест", user_id: user1.id) }

  it "should login after registration user" do
    visit root_path
    click_link "Зарегистрироваться"
    fill_in "user_email", with: "test@email.com"
    fill_in "user_password", with: "qwerty"
    fill_in "user_password_confirmation", with: "qwerty"
    click_button "ОК"
    expect(page).to have_content "Добро пожаловать!"
  end

  it "should show card only if user is owner" do
    login("u1@mail.com", "123")
    visit cards_path
    expect(page).to have_content "Тест"
  end

  it "shouldn't show card if user is no owner" do
    login("u2@mail.com", "123")
    visit cards_path
    expect(page).not_to have_content "Тест"
  end

  it "should change card only if user is owner" do
    login("u1@mail.com", "123")
    visit edit_card_path(card)
    expect(page).to have_content "Изменить карточку"
  end

  it "shouldn't change card if user is no owner" do
    login("u2@mail.com", "123")
    visit edit_card_path(card)
    expect(page).to have_content "Неверный пользователь"
  end
end
