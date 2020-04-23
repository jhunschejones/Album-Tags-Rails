module AppleMusic
  class AlbumSearchResult
    include ActiveModel::Model

    attr_accessor :apple_album_id, :title, :artist, :cover

    def initialize(apple_album_id:, title:, artist:, cover:)
      @apple_album_id = apple_album_id
      @title = title
      @artist = artist
      @cover = cover
    end

    def to_partial_path
      '/albums/album'
    end

    def id
      nil
    end
  end
end
