class Restaurantcuisine < ActiveRecord::Base
	has_and_belongs_to_many :homepage, dependent: :destroy
	self.primary_key = :id
end
