# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u = User.create(name: "Usuario", lastname: "Seed", email: "mail@example.com", password: "123456")
u1 = User.create(name:"Usuario1", lastname: "Seed1", email: "mail1@example.com", password: "123456")
t = Team.create(name: "Plockers")

Project.create(name: "Example", repository: "github", cost: 2, u)
