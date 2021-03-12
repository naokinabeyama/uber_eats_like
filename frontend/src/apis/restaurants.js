// APIを叩く関数 axios = promiseベース(非同期の処理の最終的な完了もしくはエラーを表すオブジェクト) 記述がシンプルになる
import axios from 'axios';
import { restaurantsIndex } from '../urls/index'

// axios.get成功した場合then、失敗、例外だった場合catchへ
export const fetchRestaurants = () => {
  return axios.get(restaurantsIndex)
    .then(res => {
      return res.data
    })
    // 通常はバリデーションエラーで画面に表示するが今回はコンソールだけ
    .catch((e) => console.error(e))
}
