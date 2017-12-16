module CategoriesHelper
	def category_arrays
		category_arr = Array.new
		Category.roots.each do |cats|
			child_category_arr = Array.new
			cats.descendants.each do |child_cat|
				if child_cat.leaf?
					child_category_arr.push([child_cat.title, child_cat.id ])
				end
			end
			category_arr.push([cats.title,child_category_arr])
		end
		return category_arr
	end

	def descendants_category(cat)
		category_arr = Array.new
		cat.descendants.each do |child_cat|
			if child_cat.leaf?
				category_arr.push(child_cat.id)
			end
		end
		return category_arr
	end

	def statistic_categories
		@main_categories = Array.new
		total = Product.all.count
		Category.roots.each do |main|
      a= Product.where(category_id: descendants_category(main)).count
      a=a*100/total
      @main_categories.push([main.title,a])
    end
    return @main_categories
	end
end
