class Image < ApplicationRecord
	belongs_to :property
	mount_uploader :image, AvatarUploader
end