ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

end

class ActionController::TestCase

      module Login
        def must_login(format)
            get_template_actions.each do |action|
                get action, :format => format
                assert_redirected_to signin_url
            end
        end

        def get_template_actions
            @controller.action_methods & @controller.class.instance_methods(false).map{|i| i.to_s}
        end

        def login_as_michi
            session[:user_id]=users(:michi).id
        end

        def login_as_niko
            session[:user_id]=users(:niko).id
        end

        def login_as_chri
            session[:user_id]=users(:chrisi).id
        end

        def login_as_hans
            session[:user_id]=users(:hans).id
        end

        def login_as_clemi
            session[:user_id]=users(:hans).id
        end
      end

end
