class CardsController < ApplicationController
  before_action :find_card, :user_check, only: [:show, :edit, :update, :destroy, :delete_picture]

  def index
    @cards = Card.of_user(current_user.id)
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to cards_path
    else
      render :new
    end
  end

  def update
    if card_params[:picture] == "delete"
      @card.update_attributes(picture: nil)
      redirect_to :back
    elsif @card.update(card_params)
      redirect_to cards_path
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :deck_id, :picture)
  end

  def find_card
    @card = Card.find(params[:id])
  end

  def user_check
    if @card.user != current_user
      flash[:warning] = "Неверный пользователь"
      redirect_back_or_to root_path
    end
  end
end
