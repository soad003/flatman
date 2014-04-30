Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_ID"], ENV["FACEBOOK_AUTH_PASSWORD"] 
  provider :google_oauth2, ENV["GOOGLE_ID"] , ENV["GOOGLE_AUTH_PASSWORD"]
end
