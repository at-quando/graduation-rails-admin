class BrandsController < ApplicationController
  load_and_authorize_resource
  
	def index
    @brand_cat=Array.new
    @brand_total=Array.new
    @brands = Brand.all
    @brands_name = @brands.collect {|x| [x.branch,x.id] }
    @sum = @brands.count
    @categories = Category.roots
    @brand_cat = statistic_brand
	end

  def update
    @brand = Brand.find_by_id(params[:brand_id])
    if @brand.update_attributes(branch: params[:brand_name])
      render js: "window.location = '#{brands_path}'", notice: "Update name of brands completed!"
    else
      redirect_to brands_path, notice: "Failed!"
    end
  end
	
	def create
    @brand = Brand.new(branch: params[:brand_name_1])
		if @brand.save
        CategoryBrand.create(category_id: params[:category_id], brand_id: @brand.id)
        redirect_to brands_path, notice: "Create brands completed!"
    else
        redirect_to brands_path, notice: "Failed!"
    end
	end

  def destroy
    @brand = Brand.find(params[:id])
    if @brand.destroy
      redirect_to brands_path, notice: "Delete brand successfully!"
    end
  end

  def load_categories
    @category_follow_brand = (Category.where(id: CategoryBrand.where(brand_id: params[:value]).map{ |x| x.category_id })).map{|y| [y.title,y.id]}
    respond_to do |format|
      format.js {}
    end
  end
end
