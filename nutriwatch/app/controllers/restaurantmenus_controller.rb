class RestaurantmenusController < ApplicationController
  def index
    @restaurantmenus = Restaurantmenu.all
  end
end
