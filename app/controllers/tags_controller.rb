class TagsController < ApplicationController
  def index
    @tags = Tag.order(:text)
  end

  def search_by_tag
    @searched_tags = Tag.where(text: params["tags"].map(&:titlecase)).order(:text).uniq(&:text)
    @albums = Album.by_tag_text(@searched_tags.map(&:text))
    all_matching_tags = @albums.flat_map(&:tags).uniq(&:text).sort_by(&:text)
    @other_tags = all_matching_tags - @searched_tags
    render :index
  end
end
