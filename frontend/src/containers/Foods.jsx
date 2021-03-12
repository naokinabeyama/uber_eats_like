// コンポーネント = 任意の入力を受け取り、画面上に表示すべきものを記述するReactを返す
import React, { Fragment } from 'react';

export const Foods = ({ match }) => {
  return (
    <Fragment>
      フード一覧
      <p>
        restaurantsIdは {match.params.restaurantsId} です
      </p>
    </Fragment>
  )
}
