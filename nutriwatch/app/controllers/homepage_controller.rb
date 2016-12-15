class HomepageController < ApplicationController
  def index
  end

  def create
    @dish_name = params[:full_dish]
    @restaurant_name = params[:full_restaurant]
    @cuisines = params[:cuisine_choices] #array
    @dietviolations = params[:diet_choices] #array
    @calorie_range = params[:cal_range] #array
    @rating_range = params[:rating_range] #array
    @price_range = params[:price_range] #array

    flash[:success] = "Welcome to Nutriwatch!"

    @query << @calorie_range[0] << " <= calories <= " << @calorie_range[1]
    @query << @rating_range[0] << " <= rating <= " << @rating_range[1]
    @query << @price_range[0] << " <= price <= " << @price_range[1]

    if !@dish_name.blank?
      @query << " AND "
      @query << "name = '" << @dish_name <<"'"
    end

    if !@restaurant_name.blank?
      @query << " AND "
      @query << "name = '" << @restaurant_name << "'"
    end

    @dishes = Dish.where(@query).reload

    @dishes.each do |dsh|
      @cuisines.each do |cuisine|
        if dsh.cuisine == cuisine
          @dishes.delete(dsh)
        end
      end
    end

    redirect_to dishes_index(@dishes), alert: "Yayyy!"
    return
    
    
    # This one is annoying to do
    # for @dishes.each do |dsh|
    #   for @dietviolations.each do |dv|
    #     if dsh.cuisine == dv
    #       @dishes.delete(dsh)
    #     end
    # end

  end

  def form 
    @restaurantcuisines = Restaurantcuisine.select(:cuisine).distinct
    @dietaryviolations = Dietaryviolation.select(:diet).distinct
  end

  def filter

    
    

  end

  private

  def homepage_params
  end

end
