# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
albums = Album.create([
  {
    apple_album_id: 716394623, 
    apple_url: "https://itunes.apple.com/us/album/the-question/716394623",
    title: "The Question", 
    artist: "Emery", 
    release_date: "2005-08-02", 
    record_company: "Tooth & Nail (TNN)",
    cover: "https://is3-ssl.mzstatic.com/image/thumb/Music4/v4/db/cd/a9/dbcda9bf-6551-a37d-0d57-3c4455b9d8dd/00724386060457.jpg/{w}x{h}bb.jpeg"
  },
  {
    apple_album_id: 1278421921, 
    apple_url: "https://itunes.apple.com/us/album/between-the-heart-and-the-synapse/1278421921",
    title: "Between the Heart and the Synapse", 
    artist: "The Receiving End of Sirens", 
    release_date: "2005-04-26",
    record_company: "Triple Crown Records",
    cover: "https://is5-ssl.mzstatic.com/image/thumb/Music118/v4/64/16/fe/6416febd-6a38-d961-0fc8-5e29f40e1e24/646920305865.jpg/{w}x{h}bb.jpeg"
  }
])

emery_songs = Song.create([
  {title: "So Cold I Could See My Breath", length: "", album_id: albums.first.id, order: 1},
  {title: "Playing With Fire", length: "", album_id: albums.first.id, order: 2},
  {title: "Returning the Smile You Have Had from the Start", length: "", album_id: albums.first.id, order: 3},
  {title: "Studying Politics", length: "", album_id: albums.first.id, order: 4},
  {title: "Left With Alibis and Lying Eyes", length: "", album_id: albums.first.id, order: 5},
  {title: "Listening to Freddie Mercury", length: "", album_id: albums.first.id, order: 6},
  {title: "The Weakest", length: "", album_id: albums.first.id, order: 7},
  {title: "Miss Behavin'", length: "", album_id: albums.first.id, order: 8},
  {title: "In Between 4th and 2nd Street", length: "", album_id: albums.first.id, order: 9},
  {title: "The Terrible Secret", length: "", album_id: albums.first.id, order: 10},
  {title: "In a Lose, Lose Situation", length: "", album_id: albums.first.id, order: 11},
  {title: "In a Win Win Situation", length: "", album_id: albums.first.id, order: 12}
])
albums.first.songs = emery_songs

treos_songs = Song.create([
  {title: "Prologue", length: "", album_id: albums[1].id, order: 1},
  {title: "Planning a Prison Break", length: "", album_id: albums[1].id, order: 2},
  {title: "The Rival Cycle", length: "", album_id: albums[1].id, order: 3},
  {title: "The Evidence", length: "", album_id: albums[1].id, order: 4},
  {title: "The War of All Against All", length: "", album_id: albums[1].id, order: 5},
  {title: "…then I Defy You, Stars", length: "", album_id: albums[1].id, order: 6},
  {title: "Intermission", length: "", album_id: albums[1].id, order: 7},
  {title: "This Armistice", length: "", album_id: albums[1].id, order: 8},
  {title: "Broadcast Quality", length: "", album_id: albums[1].id, order: 9},
  {title: "Flee the Factory", length: "", album_id: albums[1].id, order: 10},
  {title: "Dead Men Tell No Tales", length: "", album_id: albums[1].id, order: 11},
  {title: "Venona", length: "", album_id: albums[1].id, order: 12},
  {title: "Epilogue", length: "", album_id: albums[1].id, order: 13}
])
albums[1].songs = treos_songs


carl = User.create({
  display_name: "Carl Fox",
  email: "carl@foxes.com",
  password: "secret_password",
  profile_image: "https://www.picclickimg.com/00/s/NzYzWDEwNTM=/z/hbYAAOSwtmNcCL8-/$/The-Manhattan-Toy-Company-Plush-Pip-Fox-Little-_57.jpg"
})

tags = Tag.create([
  { text: "Emo", user_id: carl.id, custom_genre: true },
  { text: "Screamo", user_id: carl.id, custom_genre: true },
  { text: "Noodley Guitars", user_id: carl.id, custom_genre: false },
  { text: "2005", user_id: carl.id, custom_genre: false }
])
albums[0].tags = [tags[0], tags[1], tags[3]]
albums[1].tags = [tags[0], tags[2], tags[3]]

first_list = List.create({ user_id: carl.id, title: "The First List" })
first_list.albums = albums

# Create two sides of a connection 
# AlbumConnection.create([
#   {user_id: carl.id, album_a_id: albums[0].id, album_b_id: albums[1].id},
#   {user_id: carl.id, album_a_id: albums[1].id, album_b_id: albums[0].id}
# ])

# Create one side of a aconnection
AlbumConnection.create([
  {user_id: carl.id, album_a_id: albums[0].id, album_b_id: albums[1].id}
])

# NOTE: either of these queries will get album tags from either side, give the id of the album I'm starting with:
# 
# QUERY ONE:
# Album.find_by_sql(["SELECT * FROM albums WHERE EXISTS(SELECT NULL FROM album_connections WHERE albums.id = album_connections.album_a_id AND album_connections.album_b_id = ?) OR EXISTS(SELECT NULL FROM album_connections WHERE albums.id = album_connections.album_b_id AND album_connections.album_a_id = ?)", search_id, search_id])
# 
# QUERY TWO:
# Album.find_by_sql(["SELECT a.id, a.apple_album_id, a.title, a.artist, a.release_date, a.record_company, a.cover, a.apple_url, a.created_at, a.updated_at FROM album_connections JOIN albums a ON a.id = album_connections.album_a_id WHERE album_connections.album_b_id = ? UNION SELECT a.id, a.apple_album_id, a.title, a.artist, a.release_date, a.record_company, a.cover, a.apple_url, a.created_at, a.updated_at FROM album_connections JOIN albums a ON a.id = album_connections.album_b_id WHERE album_connections.album_a_id = ?", search_id, search_id])