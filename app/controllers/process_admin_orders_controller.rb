class ProcessAdminOrdersController < ApplicationController
  authorize_resource :class => false
  
  def index
    @waiting_orders= Array.new
    @pending_orders = Order.all.where(status: "0")
    @completed_order_items = OrderItem.all.where(status: "2")
    @delivering_orders = Order.all.where(status: "1")
    @delivered_orders =Order.all.where(status: "2")
    @pending_orders.each do |pending|
      @waiting_orders.push(pending) if pending.order_items.ids.length!=0 && pending.order_items.ids.all? { |i| @completed_order_items.ids.include?(i) }
    end
  end

   def load_process
    @order_item=Order.find(params[:value])
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def save_process
    @item=Order.find(params[:id].to_i)
    if @item.update(status: params[:value].to_i) 
       render js: "window.location = '#{process_admin_orders_path}'", notice: 'Update status of your order completed.' 
    else
      redirect_to process_orders_path , notice: 'Failed.' 
    end
  end
end
