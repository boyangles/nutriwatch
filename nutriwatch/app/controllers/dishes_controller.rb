class DishesController < ApplicationController
  PER_PAGE = 10

  def index
    page_number = params[:page] ? params[:page].to_i : 1
    dish_offset = PER_PAGE * (page_number - 1)
    @dishes     = Dish.limit(PER_PAGE).offset(dish_offset)
    @next_page  = page_number + 1 if @dishes.count == PER_PAGE
  end

  def new
    @dishes = Dish.new
  end

  def edit
    @dishes = Dish.find params[:id]
  end

  def show
    @dishes = Dish.find params[:id]
  end

  def destroy
    @dishes = Dish.find params[:id]
    @dishes.destroy
    redirect_to dishes_path
  end

  def update
    @dishes = Dish.find params[:id]

    if @dishes.update dishes_param
      flash[:success] = "Updated Dishes!"
      redirect_to restaurant_path(@dishes.r_id)
    else
      render :edit
    end
  end

  def create
    @dishes = Dish.new dishes_params

    if @dishes.save
      flash[:success] = "Added Your Dish!"
      redirect_to dishes_path(@dishes)
    else
      render :new
    end
  end

  def query
  	@dishes = Dish.where('price < 7.0 AND r_id = 1').reload
  	render :index
  end

  def self.search(d_id: nil, r_id: nil, m_id: nil, name: nil, price: nil, rating: nil, cuisine: nil, calories: nil)
    
  end

  private

  def dishes_param
    params.require(:dish).permit(:d_id, :r_id, :m_id, :name, :price, :rating, :cuisine, :calories)
  end
  # [END create]

end
