// 定数なので全て大文字, REQUEST_STATEはAPIリクエスト中に画面が今どういう状態なのかを知るための状態
// REQUEST_STATE.LOADINGはAPIリクエスト中としてローディング（くるくる回すUI）出せる
// REQUEST_STATE.OKは成功したアラートを出せる
export const REQUEST_STATE = {
  INITIAL: 'INITIAL',
  LOADING: 'LOADING',
  OK: 'OK',
}

export const HTTP_STATUS_CODE = {
  NOT_ACCEPTABLE: 406,
}
