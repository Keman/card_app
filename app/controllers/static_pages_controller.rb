class StaticPagesController < ApplicationController

  def index
    @card = Card.time_to_repeat
    @card = @card.shuffle[0]
  end

  def translation_check
    if params[:version_of_translation] == params[:correct_translation]
      c = Card.find(params[:card_id])
      flash[:message] = "Правильно :)"
    else
      flash[:message] = "Неправильно :("
    end
    redirect_to :back
  end
end
