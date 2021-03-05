module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create]

      def create
        # 例外パターン
        # 他店舗のline_foodが存在するかexists?で判断している
        if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
          return render json: {
            # すでに作成されている他店舗の情報(existing_restaurant)
            existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
            # 新しく作成しようとした新店舗の情報(new_restaurant)
            new_restaurant: Food.find(params[:food_id]).restaurant.name,
          }, status: :not_acceptable # 他店舗と新店舗の二つの情報がある為406 Not Acceptableを返す(エラー)
        end

        set_line_food(@ordered_food)

        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      private

      def set_food
        @ordered_food = Food.find(params[:food_id])
      end

      # 例外パターンに当てはまらず正常に仮注文を作成する場合
      def set_line_food(ordered_food)
        # if文ですでに同じfoodに関するline_foodが存在するか、新しくline_foodを生成するか判断する
        if ordered_food.line_food.present?
          @line_food = ordered_food.line_food
          # trueなら情報を更新
          @line_food.attributes = {
            count: ordered_food.line_food.count + params[:count],
            active: true
          }
        else
          # falseなら新規作成
          @line_food = ordered_food.build_line_food (
            coount: params[:count],
            restaurant: ordered_food.restaurant,
            active: true
          )
        end
      end
    end
  end
end
