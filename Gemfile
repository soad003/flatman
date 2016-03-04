source 'https://rubygems.org'
ruby "2.2.4"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.13'

#gem 'responders', '~> 2.0'
#gem "responders"


# postgresql
gem 'pg', '0.16.0'

# ORMapper
gem 'activerecord'

#Pushbots
gem 'push_bot'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# for minification and so on
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

#group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
#  gem 'sdoc', require: false
#end

# Twitter Bootstrap
gem 'bootstrap-sass', '~> 3.1.1'

# http accept lang, read lang from client to set proper default language
gem 'http_accept_language'

# chart js
gem 'chart-js-rails', '0.0.6'

#super cool icons
gem "font-awesome-rails"

#authorisation fb and google
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"

#angular js
gem 'angularjs-rails', '1.2.16'

#Underscore js, cool collection api's for js
gem 'underscore-rails'

# scheduler
#gem 'rufus-scheduler'

# Angular bindings bootstrap, typeahead
gem 'angular-ui-bootstrap-rails', '0.10.0'

#gem "animate-rails"

#alert box
gem 'bootbox-rails'

#calculate distance
gem 'geocoder'

gem 'paperclip'


group :production do
    # Use unicorn as the app server
    gem 'unicorn'

    #file storage in amazon cloud?? needed,
    gem 'aws-sdk'

    # mail exception notification, if something goes wrong, not yet configured
    gem 'exception_notification'

    # heroku open needs this gem
    gem 'launchy'

    gem 'rails_12factor'
end

group :development, :test do
    # Use Capistrano for deployment (app Server)
    gem 'capistrano'

    gem 'netrc'

    # developer console rails
    gem 'rb-readline'

    #javascript linter (syntax checker)
    gem 'jshint_on_rails'

    # cool way to test json api's format
    gem 'assert_json', '0.2.0'
end


# Use debugger
# gem 'debugger', group: [:development, :test]
