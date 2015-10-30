def login(email, password)
  visit root_path
  fill_in :user_sessions_email, with: email
  fill_in :user_sessions_password, with: password
  click_button (I18n.t "nav.sign_in")
end
