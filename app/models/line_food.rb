class LineFood < ApplicationRecord
  belongs_to :foods
  belongs_to :restaurant
  belopngs_to :order, optional: true

  validates :count, numericality: { greater_than: 0 }

  # scope = 複数のクエリをまとめたメソッド 簡易的に記述することができる
  scope :active, -> { where(active: true) }
  # 他の店舗のline_foodがあるかどうか
  scope :other_restaurant, -> (picked_restaurant_id) { where.not(restaurant_id: picked_restaurant_id)}

  # モデルに記述することで様々な箇所から呼び出すことができる
  def total_amount
    food.price * count
  end
end
