module AlbumHelper
  def cover_250(cover)
    cover.gsub("{w}", "250").gsub("{h}", "250")
  end
end
