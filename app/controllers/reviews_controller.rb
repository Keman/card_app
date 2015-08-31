class ReviewsController < ApplicationController
  def new
    @card = Card.for_review.first
  end

  def create
    card = Card.find(params[:card_id])
    if card.check_translation(params[:var][:version_of_translation])
      flash[:message] = "Правильно :)"
    else
      flash[:message] = "Неправильно :("
    end
    redirect_to :back
  end
end
