class Shop < ApplicationRecord
	has_many :admins, :dependent => :destroy 
	accepts_nested_attributes_for :admins, :allow_destroy => true
	has_many :products
  enum status: %w[Active Deactive]
end
