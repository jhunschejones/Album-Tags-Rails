class AlbumsController < ApplicationController

  def show
    @album = AppleMusic.album_details(params[:id])
  end
end
