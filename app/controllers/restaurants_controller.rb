class RestaurantsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

	def index
		@restaurants = Restaurant.all
	end

	def new
    if user_signed_in?
		  @restaurant = Restaurant.new
    else
      flash[:notice]
      redirect_to '/'
    end
	end

	def create
    @user = User.find(current_user)
		@restaurant = @user.restaurants.new(params[:restaurant].permit(:name, :image))
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end  

	def show
		@restaurant = Restaurant.find(params[:id])
	end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

   def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(params[:restaurant].permit(:name, :image))
    redirect_to '/restaurants'
  end

  def destroy
  	@restaurant = Restaurant.find(params[:id])
  	@restaurant.destroy
  	flash[:notice] = 'Restaurant deleted successfully'
  	redirect_to '/restaurants'
  end
end
