# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  User.create!(email: "dax@example.com", password: "password")
  User.create!(email: "ketty@example.com", password: "123456")
  User.create!(email: "pietro@example.com", password: "sierra")
end
