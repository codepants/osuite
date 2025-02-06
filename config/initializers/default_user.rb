Rails.application.config.after_initialize do
  # if defined?(User) && !Rails.env.test?
  #   unless User.exists?(email: 'me@me.com')
  #     User.create!(
  #       email: 'me@me.com',
  #       password: 'password',
  #       password_digest: BCrypt::Password.create("password"),
  #       name: 'me',
  #       admin: true
  #     )
  #   end
  # end
end 