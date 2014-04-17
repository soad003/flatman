require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "should not save user without properties" do
     user = User.new
     assert !user.save
    end

    #1|3|michael.froewis@gmx.at|facebook|1438808021|Michael Fröwis||2014-06-07 06:29:45.000000|http://graph.facebook.com/1438808021/picture|2014-04-08 06:31:08.723451|2014-04-08 06:40:47.620529

    test "should not save user without email" do
     user = User.new(provider:'facebook',
                        uid:"1438808021",
                        name:"Michael Fröwis",
                        oauth_token:"wuseldusel")
     assert !user.save
    end

        test "should not save user without properties oauth_token" do
     user = User.new(provider:'facebook',
                        uid:"1438808021",
                        name:"Michael Fröwis",
                        email:"michael.froewis@gmx.at")
     assert !user.save
    end

    test "should not save user without properties name" do
     user = User.new(provider:'facebook',
                        uid:"1438808021",
                        oauth_token:"wuseldusel",
                        email:"michael.froewis@gmx.at")
     assert !user.save
    end

    test "should not save user without properties uid" do
     user = User.new(provider:'facebook',
                        name:"Michael Fröwis",
                        oauth_token:"wuseldusel",
                        email:"michael.froewis@gmx.at")
     assert !user.save
    end


    test "should not save user without properties provider" do
     user = User.new(name:"Michael Fröwis",
                        uid:"1438808021",
                        oauth_token:"wuseldusel",
                        email:"michael.froewis@gmx.at")
     assert !user.save
    end

    test "michi should have flat" do
     user=users(:michi)
     assert user.has_flat?
    end

    test "niko should not have flat" do
     user=users(:niko)
     assert !user.has_flat?
    end

    test "should find user by cle@test.com" do
     user=User.find_by_email("cle@test.com")
     assert !user.nil?
    end

    test "should not find user by a@b.com" do
     user=User.find_by_email("a@b.com")
     assert user.nil?
    end

    test "from omniauth should save new user" do
     user=User.from_omniauth(OmniAuth::AuthHash.new(
                {
                  :provider => 'facebook',
                  :uid => '1234567',
                  :info => {
                    :nickname => 'jbloggs',
                    :email => 'joe@bloggs.com',
                    :name => 'Joe Bloggs',
                    :first_name => 'Joe',
                    :last_name => 'Bloggs',
                    :image => 'http://graph.facebook.com/1234567/picture?type=square',
                    :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
                    :location => 'Palo Alto, California',
                    :verified => true
                  },
                  :credentials => {
                    :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
                    :expires_at => 1321747205, # when the access token expires (it always will)
                    :expires => true # this will always be true
                  },
                  :extra => {
                    :raw_info => {
                      :id => '1234567',
                      :name => 'Joe Bloggs',
                      :first_name => 'Joe',
                      :last_name => 'Bloggs',
                      :link => 'http://www.facebook.com/jbloggs',
                      :username => 'jbloggs',
                      :location => { :id => '123456789', :name => 'Palo Alto, California' },
                      :gender => 'male',
                      :email => 'joe@bloggs.com',
                      :timezone => -8,
                      :locale => 'en_US',
                      :verified => true,
                      :updated_time => '2011-11-11T06:21:03+0000'
                    }
                  }
                }
        ))
     assert !user.nil?
     assert !user.id.nil?
     assert user.updated_at==user.created_at
    end

    test "from omniauth should update existing user" do
     user=User.from_omniauth(OmniAuth::AuthHash.new(
                {
                  :provider => users(:michi).provider,
                  :uid => users(:michi).uid,
                  :info => {
                    :nickname => 'jbloggs',
                    :email => 'joe@bloggs.com',
                    :name => 'Joe Bloggs',
                    :first_name => 'Joe',
                    :last_name => 'Bloggs',
                    :image => 'http://graph.facebook.com/1234567/picture?type=square',
                    :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
                    :location => 'Palo Alto, California',
                    :verified => true
                  },
                  :credentials => {
                    :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
                    :expires_at => 1321747205, # when the access token expires (it always will)
                    :expires => true # this will always be true
                  },
                  :extra => {
                    :raw_info => {
                      :id => '1234567',
                      :name => 'Joe Bloggs',
                      :first_name => 'Joe',
                      :last_name => 'Bloggs',
                      :link => 'http://www.facebook.com/jbloggs',
                      :username => 'jbloggs',
                      :location => { :id => '123456789', :name => 'Palo Alto, California' },
                      :gender => 'male',
                      :email => 'joe@bloggs.com',
                      :timezone => -8,
                      :locale => 'en_US',
                      :verified => true,
                      :updated_time => '2011-11-11T06:21:03+0000'
                    }
                  }
                }
        ))
     assert !user.nil?
     assert !user.id.nil?
     assert user.updated_at!=user.created_at
    end
end
