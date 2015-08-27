class ReviewsController < ApplicationController
  def new
    @card = Card.for_review.first
  end
  def create
    card = Card.find(params[:card_id])
    if card.translation_check(params[:version_of_translation],
                              params[:correct_translation])
      flash[:message] = "Правильно :)"
    else
      flash[:message] = "Неправильно :("
    end
    redirect_to :back
  end
end
