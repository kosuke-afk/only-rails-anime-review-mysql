# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password ="password"
  User.create!(name: name,
               email: email, 
               password: password,
               password_confirmation: password)
end
releases = Release.register(2011,2023)
Work.register_annict_data(releases)
Cast.all_register
Episode.all_register
EpisodeRate.create_sample_rates(title_counts: 20)
WorkRate.create_sample_rates


  

