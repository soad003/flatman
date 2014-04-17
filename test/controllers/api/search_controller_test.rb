require 'test_helper'

class Api::SearchControllerTest < ActionController::TestCase
  include AssertJson
  include Login

  test "should not get data without login" do
    must_login('json')
  end

  test "should get index and respose has valid format" do
    login_as_michi
    get :search, :format => 'json'
    assert_response :success
    assert_json(@response.body) do
      has 'items'
    end
  end
end
