# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
cities = [
  {:name => "Tokyo", :lat => 35.45, :long => 139.45, :timezone => "Asia/Tokyo"},
  {:name => "Taipei", :lat => 25.02, :long => 121.31, :timezone => "Asia/Taipei"},
  {:name => "Manila", :lat => 14.35, :long => 120.58, :timezone => "Asia/Taipei"},
  {:name => "Singapore", :lat => 1.25, :long => 103.50, :timezone => "Asia/Singapore"},
  {:name => "Berlin", :lat => 52.32, :long => 13.25, :timezone => "Europe/Berlin"},
  {:name => "Madrid", :lat => 40.25, :long => 3.42, :timezone => "Europe/Madrid"},
  {:name => "Buenos Aires", :lat => 34.34, :long => 58.03, :timezone => "America/Argentina/Buenos_Aires"},
]

cities.each do |city|
  City.find_or_create_by! name: city[:name], lat: city[:lat], long: city[:long], timezone: city[:timezone]
end
