require 'test_helper'

class Api::UserControllerTest < ActionController::TestCase
  include AssertJson
  include Login

  test 'should not get data without login' do
    must_login('json')
  end

  test 'should get index and respose has valid format' do
    login_as_michi
    get :index, format: 'json'
    assert_response :success
    assert_json(@response.body) do
      has 'name'
      has 'email'
      has 'image_path'
      has 'id'
      has_not 'oauth_token'
      has_not 'uid'
    end
  end
end
