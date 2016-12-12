class HomepageController < ApplicationController

  def index
  end

  def form 
    @restaurantcuisines = Restaurantcuisine.select(:cuisine).distinct
    @dietaryviolations = Dietaryviolation.select(:diet).distinct
    @results = params[:filter]
  end

end
