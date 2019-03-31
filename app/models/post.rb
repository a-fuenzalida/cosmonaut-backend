class Post < ApplicationRecord
  belongs_to :user, primary_key: 'id'
  
  has_many :likes
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comments

  mount_base64_uploader :image, ImageUploader
end
