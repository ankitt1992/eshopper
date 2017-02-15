# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## To Create Admin user
Admin.create({ email: 'admin@admin.com', password: '123456' })
Admin.create({email: 'ankit.neosoft@gmail.com', password: '123456'})