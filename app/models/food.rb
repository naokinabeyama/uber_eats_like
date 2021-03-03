class Food < ApplicationRecord
  belongs_to :restaurant
  belongs_to :order, optional: true
  # has_one １対１
  has_one :like_food
end
