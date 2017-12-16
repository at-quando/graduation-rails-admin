class CategoriesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @categories = Category.all
    total = Product.all.count
    @sum=@categories.count
  end

  def create
    if params[:main_category_name]
      Category.create(title: params[:main_category_name])
      redirect_to categories_path, notice: "create root category successfully!"
    elsif params[:sub_category_name]
      @parent=Category.find_by(id: params[:parent_id])
      @child=Category.create(title: params[:sub_category_name])
      @child.move_to_child_of(@parent)
      redirect_to categories_path, notice: "create sub category successfully!"
    else
      redirect_to categories_path, notice: "Something wrong!"
    end
  end

  def action
    @category = Category.find(params[:value].to_i)
    respond_to do |format|
      format.js {}
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, notice: "Delete category successfully!"
    end
  end
end
