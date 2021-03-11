import React from 'react';
import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from "react-router-dom";

import { Restaurants } from './containers/Restaurants.jsx';
import { Foods } from './containers/Foods.jsx';
import { Orders } from './containers/Orders.jsx';

// React Router = <Router>で全体を囲みルーティング先のコンポーネントを<Switch>で囲む, １ページへのルーティングを表すのが<Route>
function App() {
  return (
    <Router>
      <Switch>
        {/* 店舗一覧ページ */}
        {/* exact = PATHの完全一致のみ場合にのみコンポーネントをレンダリング */}
        <Route
          exact
          path="/restaurants">
          <Restaurants />
        </Route>
        {/* フード一覧ページ */}
        <Route
          exact
          path="/foods">
          <Foods />
        </Route>
        {/* 注文ページ */}
        <Route
          exact
          path="/orders">
          <Orders />
        </Route>
        <Route
          exact
          path="/restaurants/:restaurantsId/foods" //パラメータとして設定したい部分は:をつける
          render={({ match }) =>
            <Foods
              match={match}
            />
          }
        />
      </Switch>
    </Router>
  );
}

export default App;
