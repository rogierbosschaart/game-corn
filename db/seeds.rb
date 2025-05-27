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
# Define some common platforms and genres for items
platforms = %w[PC XBOX PlayStation Nintendo Sega]
genres = %w[RPG Shooter Strategy Racing Slasher Horror Stealth Platformer Action]
photo = URI.parse("https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FM%2FMV5BN2I3NjZmN2YtNGQ0Yi00ZWUwLThlMGQtOWI4YmMxMTA1YTQyXkEyXkFqcGdeQXVyMTU0NTQxNTM4._V1_FMjpg_UX1000_.jpg&f=1&nofb=1&ipt=e8a570f6770f796d729d6c50ff86563bc8b7318bc04f5b7e91152d73f5ac9e19").open

items = []
users.each_with_index do |user, user_index|
  rand(3..7).times do |item_index| # Each user creates between 3 and 7 items
    title = "Game Title #{user_index * 10 + item_index + 1}" # Unique title generation
    # Ensure title is unique across all items (though with this simple generation, it should be)
    # while Item.exists?(title: title) # This check is less necessary without Faker's randomness
    #   title = "Game Title #{rand(1000..9999)}"
    # end

    item = Item.new(
      title: title,
      platform: platforms.sample,
      genre: genres.sample,
      description: "This is a sample description for #{title}. It's a great game!",
      user: user
    )
    item.photo.attach(io: photo, filename: "#{item.title}.jpg", content_type: "image/jpg" ) # Simple placeholder image
    item.save
    items << item
    puts "Created item: '#{item.title}' by #{user.username}"
  end
end
puts "#{items.count} items created!"

puts "Creating offers..."
# Create some offers
# Ensure offers are between different users and for existing items
offers_count = 0
15.times do |i| # Create 15 sample offers
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
