import { RECEIVE_ALL_POKEMON } from '../actions/pokemon_actions';

const pokemonReducer = (state={}, action) => {
  Object.freeze(state);
  let nextState = Object.assign({}, state);

  switch(action.type){
    case RECEIVE_ALL_POKEMON:
      let nextState = {};
      action.pokemon.forEach(poke => {
        nextState[poke.id] = poke;
      })
      return nextState;
    default:
      return state;
  } 
}

export default pokemonReducer;