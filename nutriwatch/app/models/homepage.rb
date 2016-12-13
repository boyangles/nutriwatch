class Homepage < ActiveRecord::Base

	has_and_belongs_to_many :restaurantecuisine
	has_and_belongs_to_many :dietaryviolation

	before_save { self.d_name = d_name.downcase } if ':d_name.present?'
	before_save { self.r_name = r_name.downcase } if ':r_name.present?'

	validates :c_max, numericality: { only_integer: true, less_than_or_equal_to: 5000, greater_than_or_equal_to: :c_min }
	validates :c_min, numericality: { only_integer: true, less_than_or_equal_to: :c_max, greater_than_or_equal_to: 0 }

	validates :r_max, numericality: { only_integer: true, less_than_or_equal_to: 5, greater_than_or_equal_to: :r_min }
	validates :r_min, numericality: { only_integer: true, less_than_or_equal_to: :r_max, greater_than_or_equal_to: 0 }

	validates :p_max, numericality: { only_integer: true, less_than_or_equal_to: 50, greater_than_or_equal_to: :p_min }
	validates :p_min, numericality: { only_integer: true, less_than_or_equal_to: :p_max, greater_than_or_equal_to: 0 }

    validates_associated :restaurantecuisine
    validates_associated :dietaryviolation



end