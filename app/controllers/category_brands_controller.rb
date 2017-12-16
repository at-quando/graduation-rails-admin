class CategoryBrandsController < ApplicationController
  load_and_authorize_resource
  
  def create
    if CategoryBrand.create(brand_id: params[:rela_brand], category_id: params[:rela_category])
      redirect_to brands_path, notice: 'Add relationship successful!'
    else
      redirect_to brands_path, notice: 'Failed!'

    end
  end

  def destroy_relationship
    @category=CategoryBrand.find_by(category_id: params[:category_id])
    if @category.destroy
      render js: "window.location = '#{brands_path}'", notice: "Delete relationship successful!"
    else
      render js: "window.location = '#{brands_path}'", notice: "Failed!"
    end
  end
end
