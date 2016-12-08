class RestaurantcuisinesController < ApplicationController
  def index
    @restaurantcuisines = Restaurantcuisine.all
  end
end
