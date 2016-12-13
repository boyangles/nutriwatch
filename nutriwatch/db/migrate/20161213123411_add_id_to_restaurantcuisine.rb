class AddIdToRestaurantcuisine < ActiveRecord::Migration
  def change
    add_column :restaurantcuisines, :id, :primary_key
  end
end
