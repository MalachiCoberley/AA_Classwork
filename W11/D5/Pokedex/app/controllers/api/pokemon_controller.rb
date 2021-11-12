class Api::PokemonController < ApplicationController
  def index
    @pokemons = Pokemon.all
    render json: @pokemons
  end

end
