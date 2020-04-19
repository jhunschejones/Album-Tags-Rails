class Album < ApplicationRecord
  has_many :lists, through: :album_lists
  has_many :tags, through: :album_tags

  def self.by_tags(tag_list)
    tag_text_list = tag_list.collect(&:text)
    Album.where("albums.id IN (
                SELECT album_tags.album_id FROM album_tags
                JOIN tags ON tags.id = album_tags.tag_id
                WHERE tags.text IN (:tags_list)
                GROUP BY album_tags.album_id
                HAVING COUNT(DISTINCT tags.text) = :tags_count)",
                tags_list: tag_text_list,
                tags_count: tag_text_list.size)
  end

  def connections
    Album.find_by_sql(["SELECT * FROM albums WHERE EXISTS(SELECT NULL FROM album_connections WHERE albums.id = album_connections.parent_album_id AND album_connections.child_album_id = ?) OR EXISTS(SELECT NULL FROM album_connections WHERE albums.id = album_connections.child_album_id AND album_connections.parent_album_id = ?)", id, id])
  end
end
