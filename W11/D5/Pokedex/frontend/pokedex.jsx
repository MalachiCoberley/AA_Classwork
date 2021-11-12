import React from "react";
import ReactDOM from "react-dom";
import {receiveAllPokemon, requestAllPokemon} from "./actions/pokemon_actions";
import configureStore from "./store/store";
import {fetchAllPokemon} from "./util/api_util";

document.addEventListener('DOMContentLoaded', () => {
  const rootEl = document.getElementById('root');
  const store = configureStore();
  window.store = store;
  window.getState = store.getState;
  window.dispatch = store.dispatch;
  window.receiveAllPokemon = receiveAllPokemon;
  window.requestAllPokemon = requestAllPokemon;
  window.fetchAllPokemon = fetchAllPokemon;
  ReactDOM.render(<h1>Pokedex</h1>, rootEl);
});