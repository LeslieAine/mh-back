# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Define roles
roles = %w(creator client admin)

# Create roles
roles.each do |role_name|
  Role.find_or_create_by(name: role_name)
end


# File.open(Rails.root.join('db/images/download.jpeg'))

# new_post.images.attach( io: File.open(Rails.root.join('db/images/NAME_OF_YOUR_FILE.jpeg')),
# filename: 'NAME_OF_YOUR_FILE.jpeg')
