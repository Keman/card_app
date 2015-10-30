require "rails_helper"
require "support/login_helper"

describe "login and logout" do
  let!(:user) { create(:user, email: "u@mail.com", password: "123") }

  it "should correctly login user" do
    visit root_path
    fill_in "user_sessions_email", with: "u@mail.com"
    fill_in "user_sessions_password", with: "123"
    click_button I18n.t "nav.sign_in"
    expect(page).to have_content I18n.t "user_session.create.success"
  end

  it "should correctly logout user" do
    login("u@mail.com", "123")
    visit root_path
    click_link I18n.t "nav.user.logout"
    expect(page).to have_content I18n.t "user_session.destroy"
  end
end
