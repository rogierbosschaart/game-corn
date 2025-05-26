# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "!Destroying Database!"
Item.destroy_all

Item.create!(title: "Mass Effect", platform: "Xbox", genre: "RPG", description: "You must unite a diverse galaxy to thwart the rogue Spectre Saren and uncover a looming extinction threat posed by the ancient Reapers.", poster_url: "https://cdn2.steamgriddb.com/grid/425b39bda3156cf22e7ddd3d33e9a496.png")
Item.create!(title: "Resident Evil 4", platform: "Nintendo", genre: "Horror",   description: "In Resident Evil 4, U.S. agent Leon S. Kennedy is dispatched to a remote Spanish village to rescue the President's kidnapped daughter, only to confront a parasitic cult that has transformed the locals into deadly adversaries.", poster_url: "https://cdn2.steamgriddb.com/grid/a7ee11c99daa86125832bfc5e5a06cce.png")
Item.create!(title: "Contra", platform: "Sega", genre: "Shooter", description: "Elite commandos Bill Rizer and Lance Bean battle through jungles, waterfalls, and alien-infested bases to thwart the Red Falcon Organization's plan to conquer Earth.", poster_url: "https://cdn2.steamgriddb.com/grid/1923729345e16fc4f37f86392bc846ef.png")
Item.create!(title: "Paraworld", platform: "PC", genre: "Strategic", description: "Three scientists are transported to a parallel dimension where dinosaurs and primitive tribes coexist, and must unite the native factions to thwart a conspiracy by the SEAS organization aiming to dominate this world.", poster_url: "https://cdn2.steamgriddb.com/grid/65fb784a1862c1e0c5f21170ef6b7181.png")
Item.create!(title: "Gothic", platform: "PC", genre: "RPG", description: "A nameless convict is cast into a magical prison colony where he must navigate rival factions, uncover dark secrets, and confront a demonic force to escape the enchanted barrier that traps all within.", poster_url: "https://cdn2.steamgriddb.com/grid/b6648870eb61ee8a7e3419c7ceac9d0e.jpg")
Item.create!(title: "Vangers", platform: "PC", genre: "Racing", description: "You navigate a surreal, post-apocalyptic universe as a Vanger — a genetically engineered being driving a customizable Mecho vehicle—exploring interconnected worlds, engaging in vehicular combat, completing quests, and unraveling the enigmatic lore of a collapsed human civilization.", poster_url: "https://cdn2.steamgriddb.com/grid/d549dfadd1d998f609f53443874f0b3d.png")
Item.create!(title: "God of War 3", platform: "Playstation", genre: "Slasher", description: "Kratos ascends Mount Olympus to exact vengeance on Zeus and the Olympian gods, battling through gods and titans, culminating in a cataclysmic confrontation that reshapes the Greek world.", poster_url: "https://cdn2.steamgriddb.com/grid/999f434a8fbab3206c73c9800da70864.png")
Item.create!(title: "Killzone 2", platform: "Playstation", genre: "Shooter", description: "In Killzone 2, players assume the role of Sergeant Tomas Sevchenko, a battle-hardened veteran of the Interplanetary Strategic Alliance (ISA), as he leads a special forces unit on a mission to capture the Helghast leader, Emperor Scolar Visari, and halt the Helghast war machine on their home planet, Helghan.", poster_url: "https://cdn2.steamgriddb.com/grid/4d298f562e47760d2a52afb6fc553fb7.png")

puts "Created #{Item.count} movies"
