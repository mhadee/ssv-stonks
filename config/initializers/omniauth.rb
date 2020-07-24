Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitch, Rails.application.credentials.twitch[:client_id], Rails.application.credentials.twitch[:client_secret], scope: 'user:read:email+channel:read:subscriptions'
end