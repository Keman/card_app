class DecksController < ApplicationController
  before_action :find_deck, :user_check, only: [:show, :edit, :update, :destroy, :make_main, :make_common]

  def index
    @decks = Deck.of_user(current_user.id)
  end

  def new
    @deck = Deck.new
  end

  def edit
  end

  def create
    @deck = Deck.new(deck_params)
    if @deck.save
      redirect_to decks_path
    else
      render "new"
    end
  end

  def update
    if @deck.update(deck_params)
      redirect_to decks_path
    else
      render "edit"
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path
  end

  def make_main
    Deck.make_main(params[:id])
    redirect_to :back
  end

  def make_common
    Deck.make_common(params[:id])
    redirect_to :back
  end

  private

  def deck_params
    params.require(:deck).permit(:user_id, :description, :id)
  end

  def find_deck
    @deck = Deck.find(params[:id])
  end

  def user_check
    if @deck.user != current_user
      flash[:warning] = "Неверный пользователь"
      redirect_back_or_to root_path
    end
  end
end
