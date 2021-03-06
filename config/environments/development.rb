Flatman::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.action_mailer.delivery_method = :file

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.file_settings = {
      location: 'log/mails'
  }
  config.action_mailer.default_options = {
    :from => "info.flatman@gmx.at"
  }

  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   address:              'smtp.mailgun.org',
  #   port:                 587,   
  #   user_name:            'postmaster@flatman.at',
  #   password:             ENV['FLATMAN_SMTP_PASSWORD'],
  #   authentication:       'plain',
  #   enable_starttls_auto: true
  # }

  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.default_url_options = {
  #   :host => 'localhost',
  #   :port => 3000,
  #   :protocol => 'http'
  # }
  # config.action_mailer.asset_host = 'http://localhost:3000'
  # config.action_mailer.file_settings = {
  #     location: 'log/mails'
  # }
  # config.action_mailer.default_options = {
  #   :from => 'info@flatman.at'
  # }
  config.assets.precompile += %w( vendor/angular-locale_de-de.js )
  #Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?

  Rails.application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "[ERROR] ",
    :sender_address => %{"notifier_dev" <notifier@flatman.at>},
    :exception_recipients => %w{exceptions@flatman.at}
  }
  
end
