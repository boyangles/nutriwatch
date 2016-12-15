class HomepageController < ApplicationController
  def index
  end

  def form 
    @restaurantcuisines = Restaurantcuisine.select(:cuisine).distinct
    @dietaryviolations = Dietaryviolation.select(:diet).distinct
  end

  def filter
  	 @dishes = Dishingredient.find_by_sql("
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
      ORDER BY dishes.d_id")



  end

end
