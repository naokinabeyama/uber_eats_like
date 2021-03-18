import { REQUEST_STATE } from '../constants';

// export オブジェクトをjavascriptモジュールとして外部でも参照させるためにつけている。同じファイル内でのみ参照するのであればexportは不要
export const initialState = {
  // fetch＝APIからデータを取得する
  fetchState: REQUEST_STATE.INITIAL,
  // APIから取得したレストラン一覧が入ってくる
  restaurantsList: [],
};

export const restaurantsActionTypes = {
  FETCHING: 'FETCHING',
  FETCH_SUCCESS: 'FETCH_SUCCESS'
}

export const restaurantsReducer = (state, action) => {
  switch (action.type) {
    // API取得中＝fetchStateはLOADINGにスイッチ
    case restaurantsActionTypes.FETCHING:
      return {
        ...state,
        fetchState: REQUEST_STATE.LOADING,
      };
    // API取得完了＝fetchStateをOKにスイッチし、restaurantsListにデータを入れる
    case restaurantsActionTypes.FETCH_SUCCESS:
      return {
        fetchState: REQUEST_STATE.OK,
        restaurantsList: action.payload.restaurants,
      };
    default:
      throw new Error();
  }
}
