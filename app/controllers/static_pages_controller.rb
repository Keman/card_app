class StaticPagesController < ApplicationController
  def index
  end

  def show
    @cards = Card.all
  end
end
