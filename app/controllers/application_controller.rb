class ApplicationController < ActionController::API
  # あえてロード時間を１秒作りローディング状態を見る
  before_action :fake_load

  def fake_load
    sleep(1)
  end
end
