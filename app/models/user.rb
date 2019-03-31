class User < ApplicationRecord
            # Include default devise modules.
            devise :database_authenticatable, :registerable,
                    :recoverable, :rememberable, :trackable, :validatable
            include DeviseTokenAuth::Concerns::User
	has_many :posts
	has_many :user, :class_name => 'Following', :foreign_key => 'user_id'
	has_many :following, :class_name => 'Following', :foreign_key => 'following_id'
	has_many :comments
	has_many :likes

	mount_base64_uploader :picture, ImageUploader

	validates :nickname, uniqueness: true
	validates :email, uniqueness: true
end
