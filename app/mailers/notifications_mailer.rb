class NotificationsMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper

  default from: "cardappmailer@gmail.com", template_path: "mailers/notifications"

  def pending_cards(user)
    n = user.cards.for_review.count
    @l = user.locale
    if @l = "ru"
      @number_of_cards = n.to_s + " " + Russian.p(n, "карточка", "карточки", "карточек")
      mail to: user.email, subject: "У вас есть карточки для повторения!"
    else
      @number_of_cards = pluralize(n, "card")
      mail to: user.email, subject: "You have cards for repeat!"
    end
  end
end
