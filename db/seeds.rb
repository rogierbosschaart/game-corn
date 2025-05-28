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
  { title: "Disco Elysium", genre: "RPG", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/e17233dc1c4e3457d5a259c06c7eb502.jpg" },
  { title: "Resident Evil 4", genre: "Horror", platform: "Nintendo", image_url: "https://cdn2.steamgriddb.com/grid/a7ee11c99daa86125832bfc5e5a06cce.png" },
  { title: "Mass Effect", genre: "RPG", platform: "XBOX", image_url: "https://cdn2.steamgriddb.com/grid/425b39bda3156cf22e7ddd3d33e9a496.png" },
  { title: "Total War Rome 2", genre: "Strategy", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/2c9eda504b57b32348f3437ac07c1fab.png" },
  { title: "Sonic 3", genre: "Platformer", platform: "Sega", image_url: "https://cdn2.steamgriddb.com/grid/1cab590215ba392c9c62b6399c7d2bce.png" },
  { title: "Paraworld", genre: "Strategy", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/65fb784a1862c1e0c5f21170ef6b7181.png" },
  { title: "Killzone 2", genre: "Shooter", platform: "PlayStation", image_url: "https://cdn2.steamgriddb.com/grid/4d298f562e47760d2a52afb6fc553fb7.png" },
  { title: "Wasteland", genre: "RPG", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/5cbfa96104d988c6e7bdaa16d7e3fec1.png" },
  { title: "Vangers", genre: "Racing", platform: "PC", image_url: "https://cdn2.steamgriddb.com/grid/d549dfadd1d998f609f53443874f0b3d.png" }
]
items = []
game_data.each_with_index do |game, index|
  user = users.sample
  item = Item.new(
    title: game[:title],
    platform: game[:platform],
    genre: game[:genre],
    description: "This is #{game[:title]} for #{game[:platform]}. It's an amazing #{game[:genre]} game!",
    user: user
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
