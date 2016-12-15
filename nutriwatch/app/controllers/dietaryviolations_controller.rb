class DietaryviolationsController < ApplicationController
  def index
    @dietaryviolation = Dietaryviolation.all
  end

  def new
    @dietaryviolation = Dietaryviolation.new
  end

  def edit
    @dietaryviolation = Dietaryviolation.find params[:id]
  end

  def show
    @dietaryviolation = Dietaryviolation.find params[:id]    
  end

  def destroy
    @dietaryviolation = Dietaryviolation.find params[:id]
    @dietaryviolation.destroy
  end

  def create
    @dietaryviolation = Dietaryviolation.new 
  end

  private

  def dietaryviolation_params
    params.permit(:id, :ingredient, :diet)
  end
end
