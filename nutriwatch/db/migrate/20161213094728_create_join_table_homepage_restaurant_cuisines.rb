class CreateJoinTableHomepageRestaurantCuisines < ActiveRecord::Migration
  def change
    create_join_table :Homepages, :RestaurantCuisines do |t|
      # t.index [:homepage_id, :restaurantcuisine_id]
      # t.index [:restaurantcuisine_id, :homepage_id]
    end
  end
end
