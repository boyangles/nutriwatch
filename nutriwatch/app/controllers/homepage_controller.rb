class HomepageController < ApplicationController

  def index
    @homepage = Homepage.new
  end

  def new
		@homepage = Homepage.new
  end

  def form
    @homepage = Homepage.new
    @restaurantcuisines = Restaurantcuisine.select(:cuisine).distinct
    @dietaryviolations = Dietaryviolation.select(:diet).distinct
  	

    # @dishes = Dish.new
    # @results = params[:filter]

  #   if params[:colors]
  # user = current_user
  # user.color_ids = params[:colors]
  # user.save
  end

  def filter
    @homepage = Homepage.new
  	flash[:success] = "yay you did it"
  	@dishes = Dish.find(params[:name])
  	# redirect_to @dishes
  	# render dishes_index_path

  	# :dish_name #if dish name is misspelled sucks for you
  	# :restaurant_name # would make more sense to filter by location or something
  	# :restaurant_cuisine #graces is gone :(
  	# :dietary_violation #don't want anyone to die
  	# :cal_data1 #min calories
  	# :cal_data2 #max calories
  	# :rate_data1 #min rating
  	# :rate_data2 #max rating
  	# :price_data1 #min price
  	# :price_data2 #max price
  end

  private

  def homepage_params
    params.permit(:d_name, :r_name, :c_min, :c_max, :r_min, :r_max, :p_min, :p_max, { :restaurantcuisine_ids => [] }, { :dietaryviolation_ids => [] } )
  end

end
