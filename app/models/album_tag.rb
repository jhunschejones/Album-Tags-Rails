class AlbumTag < ApplicationRecord
  belongs_to :album
  belongs_to :tag
  belongs_to :user
end
