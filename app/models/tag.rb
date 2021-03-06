class Tag < ApplicationRecord
  has_many :album_tags
  has_many :albums, through: :album_tags
  has_many :users, through: :album_tags
end
