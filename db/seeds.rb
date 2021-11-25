# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

photo = Photo.create(name: "My First Photo")

photo.image_data.attach(
  io: File.open('./app/assets/images/my_image.png'),
  filename: 'my_image.png',
  content_type: 'application/png'
)
