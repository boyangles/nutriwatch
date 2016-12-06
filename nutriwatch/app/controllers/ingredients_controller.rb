class IngredientsController < ApplicationController
  PER_PAGE = 4

  def index
    page_number = params[:page] ? params[:page].to_i : 1
    ingredient_offset = PER_PAGE * (page_number - 1)
    @ingredients = Ingredient.limit(PER_PAGE).offset(ingredient_offset)
    @next_page = page_number + 1 if @ingredients.count == PER_PAGE
  end

  def new
  end
end
