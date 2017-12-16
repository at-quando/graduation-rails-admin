module BrandsHelper
	def brand_arrays
		brand_arr = Array.new
		@brands=Brand.select(:branch).distinct
		@brands.each do |brand|
			brand_arr.push(brand.branch)
		end
		return brand_arr
	end

  def statistic_brand
    brand_cat=Array.new
    @categories = Category.roots
    @categories.each do |cat|
      cat.children.each do |child_cat|
        brand_cat.push({"device": child_cat.title,"quantity": CategoryBrand.select(:brand_id).where(category_id: descendants_category(child_cat)).count})
      end
    end
    return brand_cat
  end
end
