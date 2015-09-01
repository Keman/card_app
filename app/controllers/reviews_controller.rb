class ReviewsController < ApplicationController
  def new
    @card = Card.for_review.first
  end

  def create
    card = Card.find(review_params[:card_id])
    if card.check_translation(review_params[:version_of_translation])
      flash[:message] = "Правильно :)"
    else
      flash[:message] = "Неправильно :("
    end
    redirect_to :back
  end

  private

    def review_params
      params.require(:review).permit(:card_id, :version_of_translation)
    end
end
