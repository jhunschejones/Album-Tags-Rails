class StaticPagesController < ApplicationController
  def home
  end

  def search
    respond_to do |format|
      format.html
      format.js {
        @albums = params["q"] ? AppleMusic.search(params["q"]) : []
      }
    end
  rescue AppleMusic::NoMatchingAlbumResults
    respond_to do |format|
      format.js { @albums = [] }
    end
  end
end
