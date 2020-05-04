class StaticPagesController < ApplicationController
  def home
  end

  def search
    respond_to do |format|
      @albums = params["q"] ? AppleMusic.search_results(search_string: params["q"]) : []
      format.html
      format.js
    end
  rescue AppleMusic::EmptyAlbumSearchResults
    respond_to do |format|
      format.js { @albums = [] }
    end
  end
end
