# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create default admin user
admin = User.find_or_initialize_by(email: 'me@me.com')
admin.assign_attributes(
  name: 'me',
  admin: true,
  password: 'me',
  created_at: Time.zone.parse('1978-11-10 00:00:00'),
  updated_at: Time.zone.parse('1978-11-10 00:00:00')
)
admin.save!

puts "Admin user created: #{admin.email}"
