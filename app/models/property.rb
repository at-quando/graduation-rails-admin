class Property < ApplicationRecord
	belongs_to :product
	has_many :images, :dependent => :destroy 
	has_many :order_items

end
