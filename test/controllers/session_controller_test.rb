require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  include Login

  test "should get index" do
    get :index
    assert_response :success
    assert_template layout: "layouts/welcome"
  end

  test "logout should delete session and redirect to root url" do
    login_as_michi
    get :destroy

    assert_nil session[:user_id]

    assert_redirected_to root_url
  end

  test "login with user in flat redirect to root url" do
    user=users(:michi)
    request.env['omniauth.auth'] = OmniAuth::AuthHash.new(
                {
                  :provider => user.provider,
                  :uid => user.uid,
                  :info => {
                    :email => user.email,
                    :name => 'Joe Bloggs',
                    :image => 'http://graph.facebook.com/1234567/picture?type=square'
                  },
                  :credentials => {
                    :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
                    :expires_at => 1321747205, # when the access token expires (it always will)
                    :expires => true # this will always be true
                  }
                }
        )


    assert_no_difference('Invite.count') do
      get :create, :provider => user.provider
    end

    assert_redirected_to root_url
  end

  test "login with user without flat and without invite redirect to create flat" do
    user=users(:michi_without_flat_and_without_invite)
    request.env['omniauth.auth'] = OmniAuth::AuthHash.new(
                {
                  :provider => user.provider,
                  :uid => user.uid,
                  :info => {
                    :email => user.email,
                    :name => 'Joe Bloggs',
                    :image => 'http://graph.facebook.com/1234567/picture?type=square'
                  },
                  :credentials => {
                    :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
                    :expires_at => 1321747205, # when the access token expires (it always will)
                    :expires => true # this will always be true
                  }
                }
        )

    assert_no_difference('Invite.count') do
      get :create, :provider => user.provider
    end

    assert_redirected_to root_url(:anchor => "create_flat")
  end

  test "login with user without flat and with invite" do
    user=users(:michi_without_flat_and_with_invite)
    request.env['omniauth.auth'] = OmniAuth::AuthHash.new(
                {
                  :provider => user.provider,
                  :uid => user.uid,
                  :info => {
                    :email => user.email,
                    :name => 'Joe Bloggs',
                    :image => 'http://graph.facebook.com/1234567/picture?type=square'
                  },
                  :credentials => {
                    :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
                    :expires_at => 1321747205, # when the access token expires (it always will)
                    :expires => true # this will always be true
                  }
                }
        )

    assert_difference('Invite.count',-1) do
      session[:invite_token] = "2P0BylDWfMoNn6aNShYmUg"
      get :create, :provider => user.provider
    end

    assert_redirected_to root_url
  end

end
