module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create]

      def index
        line_foods = LineFood.active # active: trueなline_foodの一覧を取得
        # linne_foodsのデータがあるか
        if line_foods.exists?
          render json: {
            # line_food.idを一つづつ取得
            line_food_ids: line_foods.map { |line_food| line_food.id},
            # 最初の店舗情報（一つの仮注文につき一つの店舗仕様のため）　line_foods.first.restaurantでも可
            restaurant: line_foods[0].restaurant,
            # 数量を返す
            count: line_foods.sum { |line_food| line_food[:count] },
            # 合計の計算（数量*値段）
            amount: line_foods.sum { |line_food| line_food.total_amount },
          }, status: :ok
        else
          # line_foodが一つも存在しない場合　リクエストは成功したが、空データ
          render json: {}, status: :no_content
        end
      end

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
