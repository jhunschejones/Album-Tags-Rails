class AlbumConnection < ApplicationRecord

  belongs_to :album_a, :class_name => :Album
  belongs_to :album_b, :class_name => :Album
  
end
