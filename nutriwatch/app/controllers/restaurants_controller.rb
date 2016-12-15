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
    @restaurantdishes = Dish.select("d_id, name, price, rating, cuisine, calories").where(r_id: params[:id])

    @vegandishes = Dishingredient.find_by_sql("
      SELECT DISTINCT dishes.d_id, dishes.r_id, dishes.m_id, dishes.name, dishes.price, dishes.rating, dishes.cuisine, dishes.calories
      FROM dishes, (
        SELECT DISTINCT d_id 
        FROM dishes
        WHERE r_id = #{params[:id]}
      EXCEPT
        SELECT DISTINCT d_id 
        FROM dishingredients, (
          SELECT DISTINCT ingredient 
          FROM dietaryviolations 
          WHERE diet='Vegan') AS r1 
        WHERE r1.ingredient = dishingredients.ingredient ) AS r2
      WHERE dishes.d_id = r2.d_id
      ORDER BY dishes.d_id
                                          ")
    
    @vegetariandishes = Dishingredient.find_by_sql("
      SELECT DISTINCT dishes.d_id, dishes.r_id, dishes.m_id, dishes.name, dishes.price, dishes.rating, dishes.cuisine, dishes.calories
      FROM dishes, (
        SELECT DISTINCT d_id 
        FROM dishes
        WHERE r_id = #{params[:id]}
      EXCEPT
        SELECT DISTINCT d_id 
        FROM dishingredients, (
          SELECT DISTINCT ingredient 
          FROM dietaryviolations 
          WHERE diet='Vegetarian') AS r1 
        WHERE r1.ingredient = dishingredients.ingredient ) AS r2
      WHERE dishes.d_id = r2.d_id
      ORDER BY dishes.d_id
                                          ")

    @glutenfreedishes = Dishingredient.find_by_sql("
      SELECT DISTINCT dishes.d_id, dishes.r_id, dishes.m_id, dishes.name, dishes.price, dishes.rating, dishes.cuisine, dishes.calories
      FROM dishes, (
        SELECT DISTINCT d_id 
        FROM dishes
        WHERE r_id = #{params[:id]}
      EXCEPT
        SELECT DISTINCT d_id 
        FROM dishingredients, (
          SELECT DISTINCT ingredient 
          FROM dietaryviolations 
          WHERE diet='Gluten Free') AS r1 
        WHERE r1.ingredient = dishingredients.ingredient ) AS r2
      WHERE dishes.d_id = r2.d_id
      ORDER BY dishes.d_id
                                          ")
 
    @nutallergydishes = Dishingredient.find_by_sql("
      SELECT DISTINCT dishes.d_id, dishes.r_id, dishes.m_id, dishes.name, dishes.price, dishes.rating, dishes.cuisine, dishes.calories
      FROM dishes, (
        SELECT DISTINCT d_id 
        FROM dishes
        WHERE r_id = #{params[:id]}
      EXCEPT
        SELECT DISTINCT d_id 
        FROM dishingredients, (
          SELECT DISTINCT ingredient 
          FROM dietaryviolations 
          WHERE diet='Nut Allergy') AS r1 
        WHERE r1.ingredient = dishingredients.ingredient ) AS r2
      WHERE dishes.d_id = r2.d_id
      ORDER BY dishes.d_id
                                          ")
  end

  def destroy
    begin
      @restaurant = Restaurant.find params[:id]
      @restaurant.destroy
      redirect_to restaurants_path
    rescue ActiveRecord::ActiveRecordError
      flash[:danger] = "You do not have the proper permissions to do this action!"
      redirect_to homepage_index_path
    end 
  end

  def update
    @restaurant = Restaurant.find params[:id]

    
    begin
    if @restaurant.update restaurant_params
      flash[:success] = "Updated Restaurant!"
      redirect_to restaurants_path
    else
      render :edit
    end
    rescue ActiveRecord::ActiveRecordError
      flash[:danger] = "You have entered invalid parameters. Unable to update."
      redirect_to restaurants_path
    end
  end

  def create
    @restaurant = Restaurant.new restaurant_params
    


    begin
    if @restaurant.save
      flash[:success] = "Added Your Restaurant!"
      redirect_to restaurants_path
    else
      render :new
    end
    rescue ActiveRecord::ActiveRecordError
      flash[:danger] = "Overlapping parameters! You are not allowed to do that."
      redirect_to restaurants_path
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:r_id, :name)
  end
end
