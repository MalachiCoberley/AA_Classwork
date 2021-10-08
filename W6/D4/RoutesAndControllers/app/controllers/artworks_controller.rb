require 'byebug'

class ArtworksController < ApplicationController

  def index
    id = params[:user_id]
    accessible_artwork = Artwork
      .left_outer_joins(:shares)
      .where("artworks.artist_id = ? OR artwork_shares.viewer_id = ?", id, id)
      .distinct

    render json: accessible_artwork
  end

  def show
    render json: get_artwork
  end

  def create
    artworks = Artwork.new(artwork_params)
    if artworks.save
      render json: artworks
    else
      render json: artworks.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    artwork = get_artwork
    if artwork.update(artwork_params)
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork = get_artwork
    artwork.destroy
    render json: artwork
  end

  private

  def get_artwork
    Artwork.find(params[:id])
  end
  
  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end

end
