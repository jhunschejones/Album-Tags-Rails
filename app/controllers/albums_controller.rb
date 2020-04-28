class AlbumsController < ApplicationController

  def show
    @album = AppleMusic.find_album(apple_album_id: params[:id])
  end
end
