class ReviewsController < ApplicationController
  def create
    if Card.new.translation_check(params[:version_of_translation],
                              params[:correct_translation],
                              params[:card_id])
      flash[:message] = "Правильно :)"
    else
      flash[:message] = "Неправильно :("
    end
    redirect_to :back
  end
end
