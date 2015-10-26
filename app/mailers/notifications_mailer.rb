class NotificationsMailer < ActionMailer::Base
  default from: "cardappmailer@gmail.com", template_path: "mailers/notifications"

  def pending_cards(user)
    pluralize = Russian.p(user.cards.for_review.count, "карточка", "карточки", "карточек")
    @number_of_cards = user.cards.for_review.count.to_s + " " + pluralize
    mail to: user.email, subject: "У вас есть карточки для повторения!"
  end
end
