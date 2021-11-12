class Api::PokemonController < ApplicationController
  def index
    @pokemons = Pokemon.all
    render json: @pokemons
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    render :show
  end

end
