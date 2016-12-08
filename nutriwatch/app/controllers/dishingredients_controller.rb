class DishingredientsController < ApplicationController
  PER_PAGE = 20

  def index
    page_number = params[:page] ? params[:page].to_i : 1
    dishingredient_offset = PER_PAGE * (page_number - 1)
    @dishingredients = Dishingredient.limit(PER_PAGE).offset(dishingredient_offset)
    @next_page = page_number + 1 if @dishingredients.count == PER_PAGE
  end

end
