class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= Admin.new # guest user (not logged in)
      if user.role=='Admin'
        can :manage, :all
        cannot :edit, :shop
        cannot :create, :product
        cannot :edit, :product
        cannot :delete, OrderItem
        cannot :edit, OrderItem
        cannot :manage, ProcessOrdersController
        cannot :manage, AssistantsController
      elsif user.role=='ShopOwner'
        can :manage, Admin, :id => user.id
        can :index, :home
        can :manage, ProcessOrdersController
        can :manage, AssistantsController
        can :manage, Shop, :id => user.shop_id 
        can :manage, Product, :shop_id => user.shop_id
        can :add, Product
        can :manage, Property do |property|
          user.shop.products.include?(property.product)
        end
        can :add, Property
        can :manage, OrderItem do |orderitem|
          user.shop.products.include?(orderitem.property.product)
        end
        cannot :delete, OrderItem
      else 
        can :index, :home
        can :manage, Product
        can :manage, Property do |property|
          user.shop.products.include?(property.product)
        end
        can :show, Shop, :id => user.shop_id 
        can :manage, Admin, :id => user.id
      end
  end
end
