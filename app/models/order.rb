class Order < ApplicationRecord
  has_many :like_foods
  has_one :restaurant, throught: :like_food

  validates :total_price, numericality: { greater_than 0 }

  # line_food, orderデーターの更新と保存
  def save_with_update_line_foods!(line_foods)
    # トランザクション(全ての処理が成功しないとコールバック)の中で行うことで２つの処理が失敗した場合全ての処理をなかったことにする
    ActiveRecord::Base.transaction do
      line_foods.each do |line_food|
        line_food.update_attributes!(active: false, order: self)
      end
      self.save!
    end
  end
end
