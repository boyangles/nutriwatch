class DietaryviolationsController < ApplicationController
  def index
    @dietaryviolations = Dietaryviolation.all
  end
end
