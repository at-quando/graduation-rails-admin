class HomeController < ApplicationController
  authorize_resource :class => false

	def index 
    if current_user.role == 'Admin'
      @sum_users=User.all.count
      @sum_products = Product.all.count
      @sum_shops = Shop.all.count
      @sum_brands = Brand.all.count
      @sum_categories = Category.all.count
      @sum_money = OrderItem.all.sum(:total)
      @brand_cat = statistic_brand
      @top4_users = ActiveRecord::Base.connection.exec_query("SELECT Users.name, Users.avatar, COUNT(T.user_id),SUM(T.total) FROM `fanatic-rails_development`.users INNER JOIN ( SELECT Orders.id, Orders.user_id, Sum(Order_items.total) as total FROM `fanatic-rails_development`.orders INNER JOIN `fanatic-rails_development`.order_items ON Orders.id = Order_items.order_id group by id ) AS T ON users.id = T.user_id group by name,avatar ORDER BY SUM(T.total) DESC limit 4;")
    elsif current_user.role == 'ShopOwner'
      @sum_money = OrderItem.where(property_id: Property.where(product_id: current_user.shop.products.ids).ids).sum(:total)
      @sum_products = Product.where(shop_id: current_user.shop_id).count
      @assistants = Shop.find(current_user.shop.id).admins.where(role: 2)
      @sum_staff = @assistants.count
      @reviews = Comment.where(product_id: Product.where(shop_id:current_user.shop_id).ids)
      @sum_review =  @reviews.count
      @status = Shop.find(current_user.shop.id).status
      @brand_cat = statistic_brand
    else
      @assistants = Shop.find(current_user.shop.id).admins.where(role: 2)
      @sum_products = Product.where(shop_id: current_user.shop_id).count
      @assistants = Shop.find(current_user.shop.id).admins.where(role: 2)
      @sum_staff = @assistants.count
      @reviews = Comment.where(product_id: Product.where(shop_id:current_user.shop_id).ids)
      @sum_review =  @reviews.count
      @status = Shop.find(current_user.shop.id).status
      @brand_cat = statistic_brand
    end
  end
  
  def update_statistic
    binding.pry
    re = Product.all.sum(:number_review)
    pro = Product.all.count
    ra = Product.all.sum(:rating)
    Statistic.create(all_reviews: re , all_products: pro , all_rating: ra)
  end
end
