class NotificationsMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper

  default from: "cardappmailer@gmail.com", template_path: "mailers/notifications"

  def pending_cards(user)
    @user = user
    mail to: @user.email, subject: (I18n.t "notifications_mailer.pending_cards.subject")
  end
end
