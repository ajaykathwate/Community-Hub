# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# interests_old = ['Music','Gaming', "Sports", 'Business', 'Crypto', 'Television', 'Animals and Pets', 'Art', 'Cars and Bikes', "Fashion", 'Food and Drink', 'History', 'Hobbies', 'Learning and Education', 'Military', 'Movies', 'Podcasts and Streaming', 'Politics', 'Programming', 'Reading and Writing', 'Spiritual', 'Science', 'Techology', 'Travel', 'Cricket', 'Health', 'Gym', 'Cooking']

# interests.each { |interest| Interest.create(name: interest) }


interests = [
  {name: "Music", url:"https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bXVzaWN8ZW58MHx8MHx8fDA%3D"},
  {name: "Gaming", url:"https://images.unsplash.com/photo-1586182987320-4f376d39d787?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGdhbWluZ3xlbnwwfHwwfHx8MA%3D%3D"},
  {name: "Sports", url:"https://images.unsplash.com/photo-1628779238951-be2c9f2a59f4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHNwb3J0c3xlbnwwfHwwfHx8MA%3D%3D"},
  {name: "Business", url:"https://images.unsplash.com/photo-1665686306574-1ace09918530?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGJ1c2luZXNzfGVufDB8fDB8fHww"},
  {name: "Crypto", url:"https://images.unsplash.com/photo-1605792657660-596af9009e82?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y3J5cHRvfGVufDB8fDB8fHww"},
  {name: "Television", url:"https://images.unsplash.com/photo-1495563125611-fa99f0cd529f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHRlbGV2aXNpb258ZW58MHx8MHx8fDA%3D"},
  {name: "Animals", url:"https://images.unsplash.com/photo-1589656966895-2f33e7653819?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8QW5pbWFsc3xlbnwwfHwwfHx8MA%3D%3D"},
  {name: "Art", url:"https://plus.unsplash.com/premium_photo-1661767490975-f31a02946f48?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8QXJ0fGVufDB8fDB8fHww"},
  {name: "Cars and Bikes", url:"https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YmlrZXN8ZW58MHx8MHx8fDA%3D"},
  {name: "Fashion", url:"https://images.unsplash.com/photo-1483985988355-763728e1935b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8RmFzaGlvbnxlbnwwfHwwfHx8MA%3D%3D"},
  {name: "Food & Drink", url: "https://images.unsplash.com/photo-1532634922-8fe0b757fb13?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGZvb2QlMjBhbmQlMjBkcmlua3N8ZW58MHx8MHx8fDA%3D"},
  {name: "History", url: "https://images.unsplash.com/photo-1596018382916-56d2e341d784?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fEhpc3RvcnklMjBpbmRpYXxlbnwwfHwwfHx8MA%3D%3D"},
  {name: "Education", url: "https://plus.unsplash.com/premium_photo-1682125773446-259ce64f9dd7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGVkdWNhdGlvbnxlbnwwfHwwfHx8MA%3D%3D"},
  {name: "Military", url:"https://images.unsplash.com/photo-1661113248101-f2881bea4abb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzh8fGluZGlhbiUyMG1pbGl0YXJ5fGVufDB8fDB8fHww"},
  {name: "Movies", url:"https://images.unsplash.com/photo-1616530940355-351fabd9524b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8TW92aWVzfGVufDB8fDB8fHww"},
  {name: "Podcasts", url:"https://plus.unsplash.com/premium_photo-1682141204118-a0d634b688e5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8UG9kY2FzdHMlMjBhbmQlMjBTdHJlYW1pbmd8ZW58MHx8MHx8fDA%3D"},
  {name: "Politics", url:"https://static.theprint.in/wp-content/uploads/2019/05/2019.jpg"},
  {name: "Programming", url:"https://images.unsplash.com/photo-1542831371-29b0f74f9713?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZ3JhbW1pbmd8ZW58MHx8MHx8fDA%3D"},
  {name: "Spiritual", url:"https://images.unsplash.com/photo-1598090216740-eb040d8c3f82?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Z2FuZXNoYXxlbnwwfHwwfHx8MA%3D%3D"},
  {name: "Technology", url:"https://plus.unsplash.com/premium_photo-1682145373962-4d76b19410ab?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8dGVjaG5vbG9neXxlbnwwfHwwfHx8MA%3D%3D"},
  {name: "Travel", url:"https://plus.unsplash.com/premium_photo-1664361480872-6416aab14696?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8dHJhdmVsfGVufDB8fDB8fHww"},
  {name: "Cricket", url:"https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Y3JpY2tldHxlbnwwfHwwfHx8MA%3D%3D"},
  {name: "Health", url:"https://images.unsplash.com/photo-1511688878353-3a2f5be94cd7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8aGVhbHRofGVufDB8fDB8fHww"},
  {name: "Gym", url: "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8R1lNfGVufDB8fDB8fHww"},
  {name: "Cooking", url: "https://images.unsplash.com/photo-1528712306091-ed0763094c98?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y29va2luZ3xlbnwwfHwwfHx8MA%3D%3D"}
]

interests.each do |interest|
  Interest.create(name: interest[:name], url: interest[:url])
end
