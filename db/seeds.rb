# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Treasury.create(bank: 0, cash: 0)
User.create(name: "عماد علي", email: "admin@alexinkegypt.net", department: "Management", password: "P@ssw0rd")
