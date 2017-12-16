class OrdersController < ApplicationController
  load_and_authorize_resource
  
	def index
    @orders = Order.all
    @sum= OrderItem.all.sum(:total)
    @num_product = OrderItem.all.sum(:quantity)
    @num_orders = @orders.count
    @num_un_orders = Order.where.not(status: "Delivered").count
    
	end
end
