class AdminsController < ApplicationController
  load_and_authorize_resource
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    @admins = Admin.all.where(role: 1)
  end

  def new
    @admin = Admin.new
  end

  def edit
    if current_user.id != params[:id].to_i
      redirect_to edit_admin_path(current_user)
      flash[:alert] = 'You dont have permissions to access info!'
    end
  end

  def create
    @admin = Admin.new(admin_params, password: password )
      if @admin.save
        redirect_to @admin, notice: 'Admin was successfully created.' 
      else
        render :new , notice: 'Failed.' 
      end
  end

  def update
      if @admin.update(admin_params)
        redirect_to @admin, notice: 'Admin was successfully updated.' 
      else
        render :edit 
      end
  end

  def destroy
    @admin.destroy
      redirect_to admins_url, notice: 'Admin was successfully destroyed.' 
  end

  private
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name,:user_name,:password, :gender,:email, :avatar, :phone)
    end
end
