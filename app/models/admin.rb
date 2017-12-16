class Admin < ApplicationRecord
	has_secure_password
	belongs_to :shop
	mount_uploader :avatar, AvatarUploader
	enum gender: %w[Male Female]
	enum role: %w[Admin ShopOwner Assistant]
end
