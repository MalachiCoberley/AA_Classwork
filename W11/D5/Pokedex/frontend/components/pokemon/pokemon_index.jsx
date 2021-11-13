import React from "react";

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props)
  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    return <div>
      <ul>
        {
          this.props.pokemon.map(poke => {
            return <li key={poke.id}>Name:{poke.name}<img src={poke.imageUrl}></img></li>
          })
        }
      </ul>
    </div>
  }
}

export default PokemonIndex;