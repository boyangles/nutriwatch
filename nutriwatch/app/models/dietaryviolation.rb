class Dietaryviolation < ActiveRecord::Base
	has_and_belongs_to_many :homepage, dependent: :destroy
end
