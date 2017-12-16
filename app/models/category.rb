class Category < ApplicationRecord
	acts_as_nested_set

  has_many :brands, through: :category_brands
  has_many :properties
  has_many :products

  def self.menu_categories
    categories = Hash.new
    Category.roots.each do |cat|
      cat_menu = Hash.new
      cat.children.each do |childCat|

        cat_leaf_at = Hash.new
        child = childCat.children.to_a
        childC = child.to_a
        childCat.children.each_with_index do |cCat, index|
          if cCat.descendants != []
            cat_leaf = Hash.new
            cat_leaf[cCat.title] = cCat.children
            childC.delete_at(index)
            childC[index] = cat_leaf
          else
            childC[index] = cCat
          end
        end
        cat_menu[childCat.title] = childC
      end
      categories[cat.title] = cat_menu
    end
    categories
  end
	
end
