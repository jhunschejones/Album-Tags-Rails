require 'httparty'

module AppleMusic
  class AlbumNotFound < StandardError; end
  class EmptyAlbumSearchResults < StandardError; end

  EXTERNAL_REQUEST_TIMEOUT = 10
  AUTHORIZATION_HEADER = { "Authorization" => "Bearer #{ENV["APPLE_MUSIC_TOKEN"]}" }
  PLACEHOLDER_IMAGE_URL = "/assets/apple_missing_artwork.svg"

  class << self
    def search_results(search_string:, offset: 0)
      clean_search = URI.encode(search_string)
      response = HTTParty.get(
        "https://api.music.apple.com/v1/catalog/us/search?term=#{clean_search}&offset=#{offset}&limit=25&types=artists,albums",
        {
          timeout: EXTERNAL_REQUEST_TIMEOUT,
          headers: AUTHORIZATION_HEADER,
          format: :json
        }
      )
      raise EmptyAlbumSearchResults if response.code != 200

      json_response = JSON.parse(response.body)
      raise EmptyAlbumSearchResults if json_response["results"].empty?

      json_response["results"]["albums"]["data"].map do |result|
        AppleMusic::AlbumSearchResult.new(
          apple_album_id: result["id"],
          title: result["attributes"]["name"],
          artist: result["attributes"]["artistName"],
          cover: result["attributes"]["artwork"]["url"]
        )
      end
    end

    def find_album(apple_album_id:)
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
        cover: json_response["data"][0]["attributes"]["artwork"]["url"],
        songs: json_response["data"][0]["relationships"]["tracks"]["data"].sort_by { |track| track["attributes"]["trackNumber"] }.map do |track|
          {
            track_number: track["attributes"]["trackNumber"],
            duration: format_song_duration(track["attributes"]["durationInMillis"]),
            name: track["attributes"]["name"],
            preview: track["attributes"]["previews"].first["url"]
          }
        end
      )
    end

    def album_cover_or_placeholder(url)
      return url if HTTParty.get(url.gsub("{w}", "200").gsub("{h}", "200"), {verify: false, timeout: 1}).code == 200
      PLACEHOLDER_IMAGE_URL
    rescue OpenSSL::SSL::SSLError, SocketError
      PLACEHOLDER_IMAGE_URL
    end

    def format_song_duration(duration_ms)
      duration_s = duration_ms / 1000
      seconds = duration_s % 60
      minutes = (duration_s / 60) % 60
      hours = duration_s / 3600

      if hours > 0
        "#{format("%02d", hours.to_s)}:#{format("%02d", minutes.to_s)}:#{format("%02d", seconds.to_s)}"
      else
        "#{format("%02d", minutes.to_s)}:#{format("%02d", seconds.to_s)}"
      end
    end
  end
end
