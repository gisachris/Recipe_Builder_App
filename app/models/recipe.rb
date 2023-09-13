class Recipe < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_foods

  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
end
