class Album < ApplicationRecord
  has_many :album_tags
  has_many :tags, through: :album_tags
  has_many :album_lists
  has_many :lists, through: :album_lists

  def self.by_tag_text(tag_text_list)
    Album.where(
      "albums.id IN (
      SELECT album_tags.album_id FROM album_tags
      JOIN tags ON tags.id = album_tags.tag_id
      WHERE tags.text IN (:tags_list)
      GROUP BY album_tags.album_id
      HAVING COUNT(DISTINCT tags.text) = :tags_count)",
      tags_list: tag_text_list,
      tags_count: tag_text_list.size
    )
  end

  def self.database_or_external(apple_album_id:)
    album = Album.includes(album_tags: [:tag, :user], album_lists: [:list, :user])
                 .where(apple_album_id: apple_album_id).first

    album.present? ? album : AppleMusic.find_album(apple_album_id: apple_album_id)
  end

  def connections
    Album.where(
      "EXISTS(
        SELECT album_connections.parent_album_id
        FROM album_connections
        WHERE albums.id = album_connections.parent_album_id
        AND album_connections.child_album_id = :album_id)
      OR EXISTS(
        SELECT album_connections.child_album_id
        FROM album_connections
        WHERE albums.id = album_connections.child_album_id
        AND album_connections.parent_album_id = :album_id)", album_id: id
    ).distinct
  end
end
