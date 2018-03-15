require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

[100 - Message.count, 0].max.times do
  Message.create(body: Faker::StarWars.wookiee_sentence)
end
