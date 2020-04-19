class AlbumConnection < ApplicationRecord
  belongs_to :parent_album_id, :class_name => :Album
  belongs_to :child_album_id, :class_name => :Album
  belongs_to :user
end
