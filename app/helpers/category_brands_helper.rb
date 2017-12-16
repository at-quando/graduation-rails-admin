module CategoryBrandsHelper
  def brand_arrays_follow_category(category_id)
    brand_arr = Array.new
    @brands=Brand.select(:branch,:id).where(id: CategoryBrand.select(:brand_id).where(category_id: category_id))
    @brands.each do |brand|
      brand_arr.push([brand.branch,brand.id])
    end
    return brand_arr
  end
end
