class Following < ApplicationRecord
  belongs_to :user, :class_name => 'User'
  belongs_to :following, :class_name => 'User'
end
