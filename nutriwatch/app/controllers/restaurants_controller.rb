class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
    @restaurant = Restaurant.find params[:id]
  end

  def show
    @restaurant = Restaurant.find params[:id]    
  end

  def destroy
    @restaurant = Restaurant.find params[:id]
    @restaurant.destroy
    flash[:success] = "Destroyed Restaurant"
    redirect_to homepage_index_path
  end

  def update
    @restaurant = Restaurant.find params[:id]

    if @restaurant.update restaurant_params
      flash[:success] = "Updated Restaurant!"
      redirect_to restaurants_path
    else
      render :edit
    end
  end

  def create
    @restaurant = Restaurant.new restaurant_params
    

    if @restaurant.save
      flash[:success] = "Added Your Restaurant!"
      redirect_to restaurants_path
    else
      render :new
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:r_id, :name)
  end
end
