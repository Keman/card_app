class StaticPagesController < ApplicationController
  def index
    @card = Card.for_review.mix.only_one[0]
  end

  def translation_check
    if Card.correct_translation(params[:version_of_translation], params[:correct_translation])
      Card.find(params[:card_id]).save
      flash[:message] = "Правильно :)"
    else
      flash[:message] = "Неправильно :("
    end
    redirect_to :back
  end
end
