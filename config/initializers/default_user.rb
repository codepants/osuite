Rails.application.config.after_initialize do
  if defined?(User) && !Rails.env.test?
    unless User.exists?(email: 'me@me.com')
      User.create!(
        email: 'me@me.com',
        password: 'password',
        password_confirmation: 'password',
        name: 'Admin User',
        admin: true
      )
    end
  end
end 