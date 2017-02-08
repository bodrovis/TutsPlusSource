Recaptcha.configure do |config|
  config.site_key  = ENV['RE_KEY']
  config.secret_key = ENV['RE_SECRET']
end