# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 3回Restaurant.new()をしている
3.times do |n|
  restaurant = Restaurant.new(
    name: "testレストラン＿#{n}",
    fee: 100,
    time_required: 10,
  )

  12.times do |m|
    # restaurant.foods.buildのすることでFppd.newすることなくfoodを生成することができる
    restaurant.foods.build(
      name: "フード名＿#{m}",
      price: 500,
      description: "フード＿#{m}の説明文です。"
    )
  end

  # データをDBに書き込む
  restaurant.save!
end
