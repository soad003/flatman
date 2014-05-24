Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FLATMAN_FACEBOOK_ID"], ENV["FLATMAN_FACEBOOK_AUTH_PASSWORD"], secure_image_url: true
  provider :google_oauth2, ENV["FLATMAN_GOOGLE_ID"] , ENV["FLATMAN_GOOGLE_AUTH_PASSWORD"]
end
