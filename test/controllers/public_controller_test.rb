require 'test_helper'

class PublicControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
    assert_template layout: "layouts/application"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_template layout: "layouts/application"
  end

  test "should get terms" do
    get :terms_and_privacy
    assert_response :success
    assert_template layout: "layouts/application"
  end
end
