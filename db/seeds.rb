# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "***Creating 10 professional personal trainers in Nairobi, Kenya****"
10.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "example-#{n + 1}@example.com"
  city = "Nairobi"
  country = "Kenya"
  service = "Personal Training"
  password = "password"
  professional = Professional.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    city: city,
    country: country,
    service: service,
    password: password,
    password_confirmation: password
  )
  details = Faker::Lorem.paragraph(7, true, 5)
  Quotation.create!(details: details, professional_id: professional.id)
end

puts "***Creating 10 professional plumbers in Nyeri, Kenya****"
10.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "example-n1-#{n + 1}@example.com"
  city = "Nyeri"
  country = "Kenya"
  service = "Plumbing"
  password = "password"
  professional = Professional.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    city: city,
    country: country,
    service: service,
    password: password,
    password_confirmation: password
  )

  details = Faker::Lorem.paragraph(7, true, 5)
  Quotation.create!(details: details, professional_id: professional.id)
end
