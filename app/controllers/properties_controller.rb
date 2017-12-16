class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def create
    @property = Property.new(property_params)
    @property.size = nil if property_params[:size] ==''
    @property.storage = nil if property_params[:storage] == ''
    @product = @property.product
    @property.color = params[:color]
      if @property.save
        params[:property][:image].each do |a|
          @image=@property.images.create(image: a)
          custom = @image["image"].slice! "image/upload/"
          @image.update(image: custom)
        end
        redirect_to edit_product_path(@product), notice: 'The new property of this product was successfully created.' 
      else
       redirect_to products_path
       flash[:danger] = 'Cannot create new property!'
      end
	end

  def destroy
    @property.destroy
    redirect_to edit_product_path(@product), notice: 'Admin was successfully destroyed.' 
  end

  def show
    
  end

	private
  def set_property
    @property = Property.find(params[:id])
    @product = @property.product
  end

	def property_params
    params.require(:property).permit( :size, :storage, :price, :product_id)
  end
end
