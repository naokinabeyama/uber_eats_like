// コンポーネント = 任意の入力を受け取り、画面上に表示すべきものを記述するReactを返す
import React, { Fragment, useEffect } from 'react';
import { fetchRestaurants } from '../apis/restaurants';

export const Restaurants = () => {
  // レンダリング時に一度だけ実行したいので第二引数にから配列[]を入れている
  useEffect(() => {
    fetchRestaurants()
      .then((data) =>
        console.log(data)
      )
  }, [])

  return (
    // Fragment リスト化 render内で親としてdiv要素を使ってしまうと出力されるHTMLが不正になってしまう為
    <Fragment>
      レストラン一覧
    </Fragment>
  )
}
