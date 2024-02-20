# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

interests = ['Music','Gaming', "Sports", 'Business', 'Crypto', 'Television', 'Celebrity', 'Animals and Pets', 'Art', 'Cars and Motor Vehicles', "Fashion", 'Food and Drink', 'History', 'Hobbies', 'Law', 'Learning and Education', 'Military', 'Movies', 'Place', 'Podcasts and Streaming', 'Politics', 'Programming', 'Reading and Writing', 'Spiritual', 'Science', 'Techology', 'Travel', 'Cricket', 'Health', 'Gym', 'Cooking']
interests.each { |interest| Interest.create(name: interest) }
