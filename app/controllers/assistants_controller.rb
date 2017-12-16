class AssistantsController < ApplicationController
  before_action :set_assistant, only: [:show, :edit, :update, :destroy]
  authorize_resource :class => AssistantsController

  def new
    @shop=Shop.find(current_user.shop.id)
    @assistants = @shop.admins.where(role: 2)
    @assistant = Admin.new
  end

  def create 
    @search = Admin.find_by(email: params[:email])
    if @search 
        redirect_to new_assistant_path, notice: 'This email is still in our system. But they work for someone else.' 
    else
      password = set_auto_password
      @assistant = Admin.new(email: params[:email], role: 'Assistant', shop_id: current_user.shop.id, password: password)
      if @assistant.save
        AdminMailer.registration_email(@assistant,password).deliver_now
        redirect_to new_assistant_path, notice: 'Your Asisstant was successfully created.' 
      else
        render :new , notice: 'Failed.' 
      end
    end
  end

  def show
    @shop=Shop.find_by(current_user.shop.id)
  end

  def destroy
    @assistant.destroy
    redirect_to new_assistant_path, notice: 'Admin was successfully destroyed.' 
  end
    
  private
  def set_assistant
    @assistant = Admin.find(params[:id])
  end

  def assistant_params
    params.require(:admin).permit(:email)
  end
end
