# モデル名は単数
class Restaurant < ApplicationRecord
  has_many :foods
  # has_many :through / 多対多
  has_many :like_foods, through: :foods
  # belogs_to option: true = Restaurant.order（外部キー）がnilでも許可
  belongs_to :order, optional: true

  validates :name, :fee, :time_required, presence: true
  validates :name, length: { maximum: 30 }
  # greater_than: ○　/　○以上
  validates :fee, numericality: { greater_than: 0} 
end
