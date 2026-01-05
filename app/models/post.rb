class Post < ApplicationRecord
  belongs_to :blog
  has_many :comments, dependent: :destroy
  has_many :categories, dependent: :destroy
end
