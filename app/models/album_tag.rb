class AlbumTag < ApplicationRecord
  belongs_to :album
  belongs_to :tag
  belongs_to :user

  after_destroy :remove_tag_if_orphaned

  private

  def remove_tag_if_orphaned
    tag.destroy unless tag.album_tags.present?
  end
end
