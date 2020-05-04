class TagsController < ApplicationController

  def index
    @tags = Tag.select(:text).distinct
  end
end
