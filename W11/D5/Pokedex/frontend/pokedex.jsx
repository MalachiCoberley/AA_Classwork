import React from "react";
import ReactDOM from "react-dom";
import {receiveAllPokemon, requestAllPokemon} from "./actions/pokemon_actions";
import configureStore from "./store/store";
import {fetchAllPokemon} from "./util/api_util";
import selectAllPokemon from "./reducers/selectors";
import Root from "./components/root";

document.addEventListener('DOMContentLoaded', () => {
  const rootEl = document.getElementById('root');
  const store = configureStore();
  window.store = store;
  window.getState = store.getState;
  window.dispatch = store.dispatch;
  window.receiveAllPokemon = receiveAllPokemon;
  window.requestAllPokemon = requestAllPokemon;
  window.fetchAllPokemon = fetchAllPokemon;
  window.selectAllPokemon = selectAllPokemon;
  ReactDOM.render(<Root store={store}/>, rootEl);
});