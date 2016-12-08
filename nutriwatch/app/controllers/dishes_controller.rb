class DishesController < ApplicationController
  PER_PAGE = 10

  def index
    page_number = params[:page] ? params[:page].to_i : 1
    dish_offset = PER_PAGE * (page_number - 1)
    @dishes     = Dish.limit(PER_PAGE).offset(dish_offset)
    @next_page  = page_number + 1 if @dishes.count == PER_PAGE
  end
end
