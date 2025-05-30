require "open-uri"
puts "Cleaning up database..."
Offer.destroy_all
Item.destroy_all
User.destroy_all
puts "Database cleaned!"
puts "Creating users..."
# Create 5 sample users
users = []
users << User.create!(username: "Tymur", city: "Amersfoort", email: "tymur@mahorka.com", password: "123456")
users << User.create!(username: "Kazybek", city: "Amsterdan", email: "kazybek@dam.com", password: "123456")
users << User.create!(username: "Rogier", city: "Amsterdan", email: "rogier@amster.com", password: "123456")
puts "#{users.count} users created!"
puts "Creating items..."
# Game data with specific images
game_data = [
  { title: "Turok", genre: "Shooter", platform: "Nintendo", image_url: "https://cdn2.steamgriddb.com/grid/cab2c21a5ddf9cadd84abda4a0dfc034.png", address: "Damstraat 1, 1012 JL Amsterdam, Netherlands" },
  { title: "Fallout : Brotherhood of Steel", genre: "RPG", platform: "XBOX", image_url: "https://cdn2.steamgriddb.com/grid/18e37deb2d36f25d6c38800f94afab02.png", address: "Korte Poten 23, 2511 EB Den Haag, Netherlands" },
  { title: "Paraworld", genre: "Strategy", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/65fb784a1862c1e0c5f21170ef6b7181.png", address: "Nieuwe Binnenweg 79, 3014 GE Rotterdam, Netherlands" },
  { title: "God of War", genre: "Slasher", platform: "PlayStation", image_url: "https://cdn2.steamgriddb.com/grid/72d0eaa80cc3412fda4a133ca1f884e8.png", address: "Markt 11, 6211 CH Maastricht, Netherlands" },
  { title: "Ecco the Dolphin", genre: "Adventure", platform: "Sega", image_url: "https://cdn2.steamgriddb.com/grid/b3d72af547b23265305eda666dd749f9.jpg", address: "Vismarkt 20, 9711 CV Groningen, Netherlands" },
  { title: "Wasteland", genre: "RPG", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/5cbfa96104d988c6e7bdaa16d7e3fec1.png", address: "Spuistraat 172, 1012 VT Amsterdam, Netherlands" },
  { title: "Killzone 2", genre: "Shooter", platform: "PlayStation", image_url: "https://cdn2.steamgriddb.com/grid/4d298f562e47760d2a52afb6fc553fb7.png", address: "Keizerstraat 12, 2584 BJ Den Haag, Netherlands" },
  { title: "Onimusha 3: Demon Siege", genre: "Slasher", platform: "PlayStation", image_url: "https://cdn2.steamgriddb.com/grid/4eb03dd1fe19a0c7441794a10bf4e2f0.png", address: "Zijlstraat 53, 2011 TK Haarlem, Netherlands" },
  { title: "Ninja Gaiden", genre: "Slasher", platform: "XBOX", image_url: "https://cdn2.steamgriddb.com/grid/c509ff5d356e4cb028b4ca174ec695e4.png", address: "Oranjestraat 30, 3811 KA Amersfoort, Netherlands" },
  { title: "Panzer Dragoon", genre: "Racing", platform: "Sega", image_url: "https://cdn2.steamgriddb.com/grid/3869571d773a65be8668a34e0d8c7dd0.png", address: "Grote Markt 3, 9712 HN Groningen, Netherlands" },
  { title: "Resident Evil 4", genre: "Horror", platform: "Nintendo", image_url: "https://cdn2.steamgriddb.com/grid/a7ee11c99daa86125832bfc5e5a06cce.png", address: "Noordeinde 88, 2514 GM Den Haag, Netherlands" },
  { title: "Resident Evil - Code: Veronica", genre: "Horror", platform: "Sega", image_url: "https://cdn2.steamgriddb.com/grid/83f52c814551f19ec1228b7e45b1e950.png", address: "Lange Hezelstraat 27, 6511 CB Nijmegen, Netherlands" },
  { title: "Resistance 3", genre: "Shooter", platform: "PlayStation", image_url: "https://cdn2.steamgriddb.com/grid/c27502ef7c67dd26c8fbbf0dc3b2eea2.png", address: "Wagenstraat 95, 2512 AT Den Haag, Netherlands" },
  { title: "Darklands", genre: "RPG", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/f97477b0af149f8a76ec557896d047df.png", address: "Pieter Vreedestraat 15, 5038 BV Tilburg, Netherlands" },
  { title: "Turok(2008)", genre: "Shooter", platform: "XBOX", image_url: "https://cdn2.steamgriddb.com/grid/8604b2a32fcb657a7a53917c2a5de324.png", address: "Hoogstraat 21, 3011 PG Rotterdam, Netherlands" },
  { title: "The Simpsons: Hit & Run", genre: "Action", platform: "XBOX", image_url: "https://cdn2.steamgriddb.com/grid/3ab7434b949fbf9a19c3fcc830c1bdf1.png", address: "Haverstraatpassage 39, 7511 ET Enschede, Netherlands" },
  { title: "The Lost Vikings", genre: "Platformer", platform: "Nintendo", image_url: "https://cdn2.steamgriddb.com/grid/ce09fd97787a8334edbe0b3168cb4370.png", address: "Kleine Houtstraat 70, 2011 DR Haarlem, Netherlands" },
  { title: "Disco Elysium", genre: "RPG", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/e17233dc1c4e3457d5a259c06c7eb502.jpg", address: "Steenweg 30, 3511 JP Utrecht, Netherlands" },
  { title: "Mass Effect", genre: "RPG", platform: "XBOX", image_url: "https://cdn2.steamgriddb.com/grid/425b39bda3156cf22e7ddd3d33e9a496.png", address: "Hinthamerstraat 72, 5211 MR 's-Hertogenbosch, Netherlands" },
  { title: "FIFA", genre: "Sports", platform: "Sega", image_url: "https://cdn2.steamgriddb.com/grid/206cb6f01d35a60f6a16969c9f4e7a70.png", address: "Brink 34, 7411 BT Deventer, Netherlands" },
  { title: "Quake", genre: "Shooter", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/50ce4e15accc45cc22de9015d991b7d4.png", address: "Grote Marktstraat 40, 2511 BJ Den Haag, Netherlands" },
  { title: "Tekken 5", genre: "Fighting", platform: "PlayStation", image_url: "https://cdn2.steamgriddb.com/grid/b2cc5b539e4dad446f89749e1ad46a38.png", address: "Molenstraat 15, 2513 BH Den Haag, Netherlands" },
  { title: "Tonny Hawk's : Underground", genre: "Sports", platform: "PlayStation", image_url: "https://cdn2.steamgriddb.com/grid/02aeed0dbac789507db95655c84c81d3.png", address: "Kruisstraat 18, 5612 CJ Eindhoven, Netherlands" },
  { title: "Total War Rome 2", genre: "Strategy", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/2c9eda504b57b32348f3437ac07c1fab.png", address: "Breestraat 89, 2311 CK Leiden, Netherlands" },
  { title: "Sonic 3", genre: "Platformer", platform: "Sega", image_url: "https://cdn2.steamgriddb.com/grid/1cab590215ba392c9c62b6399c7d2bce.png", address: "Oude Markt 12, 7511 GB Enschede, Netherlands" },
  { title: "Vangers", genre: "Racing", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/d549dfadd1d998f609f53443874f0b3d.png", address: "Voorstraat 25, 3311 EP Dordrecht, Netherlands" }
]
items = []
game_data.each_with_index do |game, index|
  user = users.sample
  item = Item.new(
    title: game[:title],
    platform: game[:platform],
    genre: game[:genre],
    description: "This is #{game[:title]} for #{game[:platform]}. It's an amazing #{game[:genre]} game!",
    user: user,
    address: game[:address]
  )
  # Attach image from URL
  begin
    file = URI.open(game[:image_url])
    item.photo.attach(io: file, filename: "#{game[:title].parameterize}.jpg", content_type: "image/#{game[:image_url].end_with?('png') ? 'png' : 'jpeg'}")
  rescue => e
    puts "Error attaching image for #{game[:title]}: #{e.message}"
  end
  item.save!
  items << item
  puts "Created item: '#{item.title}' by #{user.username}"
end
puts "#{items.count} items created!"
puts "Creating offers..."
# Create some offers
offers_count = 0
15.times do |i|
  offering_user = users.sample
  item_to_offer = items.sample
  # Ensure the offering user is not the owner of the item
  next if offering_user == item_to_offer.user
  # Generate dates manually
  start_date = Date.today + (10 + i).days
  end_date = start_date + rand(7..30).days
  offer = Offer.create!(
    item: item_to_offer,
    user: offering_user,
    start_date: start_date,
    end_date: end_date,
    comment: "This is a sample comment for offer ##{i + 1} on #{item_to_offer.title}."
  )
  offers_count += 1
  puts "Created offer for '#{item_to_offer.title}' by #{offering_user.username}"
end
puts "#{offers_count} offers created!"
puts "Seeding complete!"
