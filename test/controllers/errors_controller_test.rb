require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  test 'should get not found' do
    get :not_found
    assert_response 404
    assert_template layout: 'layouts/application'
  end

  test 'should get error' do
    get :server_error
    assert_response 500
    assert_template layout: 'layouts/application'
  end
end
