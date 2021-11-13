const selectAllPokemon = (state) => {
  let pokeArr = Object.values(state.entities.pokemon);
  return pokeArr;
}

export default selectAllPokemon;