require 'httparty'

module AppleMusic
  class AlbumNotFound < StandardError; end
  class NoMatchingAlbumResults < StandardError; end

  EXTERNAL_REQUEST_TIMEOUT = 5
  AUTHORIZATION_HEADER = { "Authorization" => "Bearer #{ENV["APPLE_MUSIC_TOKEN"]}" }
  PLACEHOLDER_IMAGE_URL = "https://music.apple.com/assets/product/MissingArtworkMusic.svg"
  AlbumSearchResult = Struct.new(:apple_album_id, :title, :artist, :cover)

  def self.search(search_string, offset=0)
    clean_search = URI.encode(search_string)
    response = HTTParty.get(
      "https://api.music.apple.com/v1/catalog/us/search?term=#{clean_search}&offset=#{offset}&limit=25&types=artists,albums",
      {
        timeout: EXTERNAL_REQUEST_TIMEOUT,
        headers: AUTHORIZATION_HEADER,
        format: :json
      }
    )
    raise NoMatchingAlbumResults if response.code != 200

    JSON.parse(response.body)["results"]["albums"]["data"].map do |result|
      AlbumSearchResult.new(
        apple_album_id: result["id"],
        title: result["attributes"]["name"],
        artist: result["attributes"]["artistName"],
        cover: album_cover_or_placeholder(result["attributes"]["artwork"]["url"])
      )
    end
  end

  def self.album_details(apple_album_id)
    response = HTTParty.get(
      "https://api.music.apple.com/v1/catalog/us/albums/#{apple_album_id}",
      {
        timeout: EXTERNAL_REQUEST_TIMEOUT,
        headers: AUTHORIZATION_HEADER,
        format: :json
      }
    )
    raise AlbumNotFound if response.code != 200
    json_response = JSON.parse(response.body)

    Album.new(
      apple_album_id: json_response["data"][0]["id"],
      apple_url: json_response["data"][0]["attributes"]["url"],
      title: json_response["data"][0]["attributes"]["name"],
      artist: json_response["data"][0]["attributes"]["artistName"],
      release_date: json_response["data"][0]["attributes"]["releaseDate"],
      record_company: json_response["data"][0]["attributes"]["recordLabel"],
      cover: album_cover_or_placeholder(json_response["data"][0]["attributes"]["artwork"]["url"]),
      songs: json_response["data"][0]["relationships"]["tracks"]["data"].sort_by { |track| track["attributes"]["trackNumber"] }.map { |track| track["attributes"]["name"] }
    )
  end

  def self.album_cover_or_placeholder(url)
    HTTParty.get(url.gsub("{w}", "200").gsub("{h}", "200"), timeout: EXTERNAL_REQUEST_TIMEOUT).code == 200
    url
  rescue SocketError
    PLACEHOLDER_IMAGE_URL
  end
end
