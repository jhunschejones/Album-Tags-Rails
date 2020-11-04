class AlbumConnection < ApplicationRecord
  belongs_to :parent_album, :class_name => :Album
  belongs_to :child_album, :class_name => :Album
  belongs_to :user

  validate :connection_not_duplicate

  private

  def connection_not_duplicate
    connection_already_esists = AlbumConnection
      .where(parent_album_id: parent_album_id, child_album_id: child_album_id)
      .or(AlbumConnection.where(parent_album_id: child_album_id, child_album_id: parent_album_id))
      .exists?

    if connection_already_esists
      errors.add(:parent_album_id, "id #{parent_album_id} is already connected to album id #{child_album_id}")
    end
  end
end
