class ShopsController < ApplicationController
  load_and_authorize_resource
	def new
    @shop = Shop.new
    @admin = @shop.admins.build
  end

  def create
    password = set_auto_password
    params[:shop][:admins_attributes]["0"][:password] = password
    params[:shop][:admins_attributes]["0"][:role] = 1
    @shop = Shop.new(shop_params)
      if @shop.save 
        AdminMailer.registration_email(@shop.admins.first,password).deliver_now
        redirect_to @shop, notice: 'shop was successfully created.' 
      else
        render :new 
      end
    end

  def show
  	 @shop = Shop.find(params[:id])
  	 @admin = @shop.admins.find_by(role: 1)
     @products = @shop.products
  	 @assistant = @shop.admins.where(role: 2)
  end

  def index
  	@shops=Shop.all
  end

  private

  def shop_params
  	params.require(:shop).permit(:name,:address, admins_attributes: [:name, :user_name, :password, :gender, :email, :role, :phone]) 
  end
end
