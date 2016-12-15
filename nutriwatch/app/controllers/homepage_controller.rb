class HomepageController < ApplicationController

  def index
    @homepage = Homepage.new
  end

  def new
		@homepage = Homepage.new
  end

  def destroy
    @homepage = homepage.find params[:id]
    @homepage.destroy
    redirect_to homepage_path
  end

  def create
    @homepage = Homepage.new(homepage_params)
    
    if @homepage.save

      @dish_name = params[:d_name]
      @restaurant_name = params[:r_name]
      @cuisines = params[:restaurantcuisine_ids] #array
      @dietviolations = params[:dietaryviolation_ids] #array
      @calorie_min = params[:c_min]
      @calorie_max = params[:c_max]
      @rating_min = params[:r_min]
      @rating_max = params[:r_max]
      @price_min = params[:p_min]
      @price_max = params[:p_min]

      @query = @calorie_min << " <= calories <= " << @calorie_max
      @query << @rating_min << " <= rating <= " << @rating_max
      @query << @price_min << " <= price <= " << @price_max

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
    else
      render :edit
    end
  end

  def edit
    @homepage = Homepage.find params[:id]
  end

  def show
    @homepage = Homepage.find params[:id]    
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
    @homepage = Homepage.new(homepage_params)
  	flash[:success] = "yay you did it"
    @dish_name = params[:d_name]
    @restaurant_name = params[:r_name]
    @cuisines = params[:restaurantcuisine_ids] #array
    @dietviolations = params[:dietaryviolation_ids] #array
    @calorie_min = params[:c_min]
    @calorie_max = params[:c_max]
    @rating_min = params[:r_min]
    @rating_max = params[:r_max]
    @price_min = params[:p_min]
    @price_max = params[:p_min]

    @query = @calorie_min << " <= calories <= " << @calorie_max
    @query << @rating_min << " <= rating <= " << @rating_max
    @query << @price_min << " <= price <= " << @price_max

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
  end

  private

  def homepage_params
    params.permit(:d_name, :r_name, :c_min, :c_max, :r_min, :r_max, :p_min, :p_max, { :restaurantcuisine_ids => [] }, { :dietaryviolation_ids => [] } )
  end

end
