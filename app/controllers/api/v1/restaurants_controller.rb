module Api
  module V1
    class RestaurantsController < ApplicationController
      def index
        restaurants = Restaurant.all

        # JSON形式で出力
        render json: {
          restaurants: restaurants
        }, status: :ok  # リクエストが成功したこと 200 okと一緒にデータを返す
      end
    end
  end
end
