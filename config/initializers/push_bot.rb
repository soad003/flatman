PushBot.configure do |config|
  config.id = ENV["FLATMAN_PUSHBOT_ID"]
  config.secret = ENV["FLATMAN_PUSHBOT_SECRET"]
end