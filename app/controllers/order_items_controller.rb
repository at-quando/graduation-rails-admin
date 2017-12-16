class OrderItemsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @order_items = OrderItem.where(property_id: Property.where(product_id: current_user.shop.products.ids).ids)
    @sum = @order_items.sum(:total)
    @quantity = @order_items.sum(:quantity)
  end

  def show
  end

  
end
