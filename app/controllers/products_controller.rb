class ProductsController < ApplicationController
  load_and_authorize_resource
	before_action :set_product, only: [:edit, :show, :destroy]
  
	def index
		@products = Product.where(shop_id: current_user.shop_id)
		@product = Product.new
		@property = @product.properties.build
	end

	def create
		@product = Product.new(product_params)
    @product.category_id = params[:category_id]
		@product.brand_id = params[:brand_id]
		if @product.save 
			params[:product][:images].each do |a|
        @image = @product.properties[0].images.create(image: a)
        custom = @image["image"].slice! "image/upload/"
        @image.update(image: custom)
			end
			Statistic.update_all("all_products = all_products +1")
      redirect_to edit_product_path(@product), notice: 'Product was successfully created with their property.' 
		else
      render :index
      flash[:danger]="Something went wrong. Try to do again!"
    end
	end

	def destroy
		@product.destroy
		redirect_to products_path, notice: 'Delete product completed'
	end

	def edit
		@property = Property.new
	end

	def update
		@product.category_id = params[:category_id]
		if @product.update(product_params)
			redirect_to edit_product_path, notice: 'Update Product information successfully!'
		else
			render :edit
			flash[:danger]= 'Cannot update'
		end
	end

	def getBrand
		@arr = Array.new
		@arr = brand_arrays_follow_category(params[:valueCat])
		respond_to do |format|
			format.js { render :layout => false }
			format.json { render json: @arr }
		end
	end

	private

	def set_product
		@product=Product.find(params[:id])
	end

def product_params
    params.require(:product).permit(:name, :description, :category_id, :shop_id, properties_attributes: [:size, :price, :storage, :color])
  end

end
