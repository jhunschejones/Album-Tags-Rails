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
