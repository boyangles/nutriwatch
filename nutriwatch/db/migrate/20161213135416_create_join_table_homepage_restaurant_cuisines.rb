class CreateJoinTableHomepageRestaurantCuisines < ActiveRecord::Migration
  def change
  	drop_join_table :homepage, :restaurantcuisine
    create_join_table :homepage, :restaurantcuisine do |t|
      t.index [:homepage_id, :restaurant_cuisine_id]
      t.index [:restaurant_cuisine_id, :homepage_id]
    end
  end
end
