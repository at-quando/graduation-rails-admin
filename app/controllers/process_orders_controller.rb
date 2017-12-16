class ProcessOrdersController < ApplicationController
  authorize_resource :class => ProcessOrdersController
  
  def index
    @order_items = OrderItem.where(property_id: Property.where(product_id: current_user.shop.products.ids).ids)
    @pending_orders = OrderItem.where(order_id: Order.where(status: "0").ids, property_id: Property.where(product_id: current_user.shop.products.ids).ids)
    @delivering_orders = OrderItem.where(order_id: Order.where(status: "1").ids, property_id: Property.where(product_id: current_user.shop.products.ids).ids)
    @delivered_orders = OrderItem.where(order_id: Order.where(status: "2").ids, property_id: Property.where(product_id: current_user.shop.products.ids).ids)
  end

  def load_process
    @order_item=OrderItem.find(params[:value])
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def save_process
    @item=OrderItem.find(params[:id].to_i)
    if @item.update(status: params[:value].to_i) 
       render js: "window.location = '#{process_orders_path}'", notice: 'Update status of your order completed.' 
    else
      redirect_to process_orders_path , notice: 'Failed.' 
    end
  end
end
