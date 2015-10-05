require "rails_helper"
require "support/login_helper"

describe "login and logout" do
  let!(:user) { create(:user, email: "u@mail.com", password: "123") }

  it "should correctly login user" do
    visit root_path
    click_link "Войти"
    fill_in "user_sessions_email", with: "u@mail.com"
    fill_in "user_sessions_password", with: "123"
    click_button "Войти"
    expect(page).to have_content "Привет!"
  end

  it "should correctly logout user" do
    login("u@mail.com", "123")
    visit root_path
    click_link "Выйти"
    expect(page).to have_content "До встречи!"
  end
end
