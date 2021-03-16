// コンポーネント = 任意の入力を受け取り、画面上に表示すべきものを記述するReactを返す
import React, { Fragment, useEffect } from 'react';
// styled-componentsを使用する
import styled from 'styled-components';
import { fetchRestaurants } from '../apis/restaurants';
import MainLogo from '../images/logo.png';
import MainCoverImage from '../images/main-cover-image.png';

const HeaderWrapper = styled.div`
  display: flex;
  // justify-content 中身のアイテムの間や周囲に間隔を配置
  justify-content: flex-start;
  padding: 8px 32px;
  `;

const MainLogoImage = styled.img`
  height: 90px;
  `;

const MainCoverImageWrapper = styled.div`
text-align: center;
`;

const MainCover = styled.img`
height: 600px;
`;

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
      <HeaderWrapper>
        <MainLogoImage src={MainLogo} alt="main logo" />
      </HeaderWrapper>
      <MainCoverImageWrapper>
        <MainCover src={MainCoverImage} alt="main cover" />
      </MainCoverImageWrapper>
    </Fragment>
  )
}
