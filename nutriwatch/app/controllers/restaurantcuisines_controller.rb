class RestaurantcuisinesController < ApplicationController
  def index
    @restaurantcuisine = Restaurantcuisine.all
  end

  def new
    @restaurantcuisine = Restaurantcuisine.new
  end

  def edit
    @restaurantcuisine = Restaurantcuisine.find params[:id]
  end

  def show
    @restaurantcuisine = Restaurantcuisine.find params[:id]    
  end

  def destroy
    @restaurantcuisine = Restaurantcuisine.find params[:id]
    @restaurantcuisine.destroy
  end

  def create
    @restaurantcuisine = Restaurantcuisine.new 
  end

  private

  def restaurant_params
    params.permit(:r_id, :name)
  end
end
