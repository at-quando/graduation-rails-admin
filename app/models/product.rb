class Product < ApplicationRecord
	belongs_to :category
	has_many :properties, :dependent => :destroy 
	belongs_to :brand
	has_many :comments
  has_many :order_items
	belongs_to :shop
	accepts_nested_attributes_for :properties, :allow_destroy => true
end
