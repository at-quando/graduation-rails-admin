class User < ApplicationRecord
	has_many :authentications
	has_many :orders
	has_many :comments
end
