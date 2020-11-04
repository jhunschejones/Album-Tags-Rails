# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# path to your application root.
APP_ROOT = File.expand_path('..', __dir__)

FileUtils.chdir APP_ROOT do
  system '. ./tmp/.env'
end

if User.count == 0
  User.create(name: "Joshua", email: ENV['EMAIL_USERNAME'], password: ENV['DEV_PASSWORD'], password_confirmation: ENV['DEV_PASSWORD'], confirmed_at: Time.now.utc, site_role: "site_admin")
end

if Album.count == 0
  josh_user = User.where(email: ENV['EMAIL_USERNAME']).first

  scary_kids_scaring_kids = AppleMusic.find_album(apple_album_id: "265378374")
  scary_kids_scaring_kids.save!
  the_city_sleeps_in_flames = AppleMusic.find_album(apple_album_id: "1359729647")
  the_city_sleeps_in_flames.save!
  the_question = AppleMusic.find_album(apple_album_id: "716394623")
  the_question.save!
  if_only_you_were_lonely = AppleMusic.find_album(apple_album_id: "464931799")
  if_only_you_were_lonely.save!

  emo_tag = Tag.create!(text: "Emo")
  screamo_tag = Tag.create!(text: "Screamo")
  tag_2005 = Tag.create!(text: "2005")
  tag_2006 = Tag.create!(text: "2006")
  tag_2007 = Tag.create!(text: "2007")

  AlbumTag.create!(tag_id: emo_tag.id, user_id: josh_user.id, album_id: scary_kids_scaring_kids.id)
  AlbumTag.create!(tag_id: emo_tag.id, user_id: josh_user.id, album_id: the_question.id)
  AlbumTag.create!(tag_id: screamo_tag.id, user_id: josh_user.id, album_id: scary_kids_scaring_kids.id)
  AlbumTag.create!(tag_id: screamo_tag.id, user_id: josh_user.id, album_id: the_city_sleeps_in_flames.id)
  AlbumTag.create!(tag_id: screamo_tag.id, user_id: josh_user.id, album_id: the_question.id)
  AlbumTag.create!(tag_id: screamo_tag.id, user_id: josh_user.id, album_id: if_only_you_were_lonely.id)
  AlbumTag.create!(tag_id: tag_2007.id, user_id: josh_user.id, album_id: scary_kids_scaring_kids.id)
  AlbumTag.create!(tag_id: tag_2005.id, user_id: josh_user.id, album_id: the_question.id)
  AlbumTag.create!(tag_id: tag_2006.id, user_id: josh_user.id, album_id: if_only_you_were_lonely.id)
  AlbumTag.create!(tag_id: tag_2005.id, user_id: josh_user.id, album_id: the_city_sleeps_in_flames.id)

  AlbumConnection.create!(user_id: josh_user.id, parent_album: the_question, child_album: scary_kids_scaring_kids)
  AlbumConnection.create!(user_id: josh_user.id, parent_album: scary_kids_scaring_kids, child_album: the_city_sleeps_in_flames)
  AlbumConnection.create!(user_id: josh_user.id, parent_album: scary_kids_scaring_kids, child_album: if_only_you_were_lonely)
end
