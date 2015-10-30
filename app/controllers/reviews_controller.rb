class ReviewsController < ApplicationController
  def new
    main_deck = Deck.find_by(user: current_user, main: true)
    @card = main_deck.present? ? Card.of_deck(main_deck.id).for_review.first : Card.of_user(current_user.id).for_review.first
  end

  def create
    card = Card.find(review_params[:card_id])
    if card.check_translation(review_params[:version_of_translation])
      flash[:success] = t "review.success"
    else
      if DamerauLevenshtein.distance(review_params[:version_of_translation], card.translated_text, 1) < 2
        flash[:warning] = t "review.warning", version: review_params[:version_of_translation], translate: card.translated_text
      else
        flash[:danger] = t "review.danger"
      end
    end
    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :version_of_translation)
  end
end
