class NotificationsMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper

  default from: "cardappmailer@gmail.com", template_path: "mailers/notifications"

  def pending_cards(user)
    n = user.cards.for_review.count
    @l = user.locale
    @number_of_cards = @l = "ru" ? n.to_s + " " + Russian.p(n, "карточка", "карточки", "карточек") : pluralize(n, "card")
    mail to: user.email, subject: I18n.t "notifications_mailer.pending_cards.subject"
  end
end
