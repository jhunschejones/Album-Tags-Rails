class Album < ApplicationRecord

  # to load with the following data, try `Album.includes(:songs, :tags, :lists).find(query_id)`
  has_many :songs
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :lists

  # Album connections
  has_many :album_connections, :foreign_key => :album_a_id # may need to add :dependant => :destroy if orphaned refrences start appearing
  has_many :albums, :through => :album_connections, :source => :album_b

  scope :connections, lambda {|search_id| find_by_sql(["SELECT * FROM albums WHERE EXISTS(SELECT NULL FROM album_connections WHERE albums.id = album_connections.album_a_id AND album_connections.album_b_id = ?) OR EXISTS(SELECT NULL FROM album_connections WHERE albums.id = album_connections.album_b_id AND album_connections.album_a_id = ?)", search_id, search_id]) }

  # This alternate query also returns the same results as above, is the first way faster? 
  # This second query may also be able to be sped up with `UNION ALL`
  # scope :connections, lambda {|search_id| find_by_sql(["SELECT a.id, a.apple_album_id, a.title, a.artist, a.release_date, a.record_company, a.cover, a.apple_url, a.created_at, a.updated_at FROM album_connections JOIN albums a ON a.id = album_connections.album_a_id WHERE album_connections.album_b_id = ? UNION SELECT a.id, a.apple_album_id, a.title, a.artist, a.release_date, a.record_company, a.cover, a.apple_url, a.created_at, a.updated_at FROM album_connections JOIN albums a ON a.id = album_connections.album_b_id WHERE album_connections.album_a_id = ?", search_id, search_id]) }
end
