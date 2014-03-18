Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '677256425671969', 'd30b0787463b44e36bcce433cfdc38de'
  provider :google_oauth2, '165604899689-t4csosbl1k752vdrg1hldclnbtae2bg9.apps.googleusercontent.com', 'V9XBa-TEqZbI0dK32TAyxu0j'
end
