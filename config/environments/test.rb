Flatman::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = true

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = "public, max-age=3600"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = true

  # Disable request forgery protection in test environment.
  #config.action_controller.allow_forgery_protection = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # important for testing do not touch !
  # http://zergsoft.blogspot.co.at/2012/09/rails-functional-testing-session.html
  config.action_controller.allow_forgery_protection = false

  config.action_mailer.delivery_method = :file

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.file_settings = {
      location: 'log/mails'
  }
  config.action_mailer.default_options = {
    :from => "info.flatman@gmx.at"
  }

end
