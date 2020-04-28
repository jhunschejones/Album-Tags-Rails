class StaticPagesController < ApplicationController
  def home
  end

  def search
    respond_to do |format|
      format.html
      format.js {
        @albums = params["q"] ? AppleMusic.search_results(search_string: params["q"]) : []
      }
    end
  rescue AppleMusic::EmptyAlbumSearchResults
    respond_to do |format|
      format.js { @albums = [] }
    end
  end
end
