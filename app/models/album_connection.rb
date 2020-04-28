class AlbumConnection < ApplicationRecord
  belongs_to :parent_album, :class_name => :Album
  belongs_to :child_album, :class_name => :Album
  belongs_to :user
end
