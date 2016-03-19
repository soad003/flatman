require 'test_helper'

class TemplatesControllerTest < ActionController::TestCase
  include Login

  test 'should not get data without login' do
    must_login('html')
  end

  test 'should get templates when loggedin' do
    session[:user_id] = users(:michi).id
    (get_template_actions - ['index']).each do |action|
      get action
      assert_response :success
      assert_template layout: nil
    end
  end

  test 'should get index when loggedin' do
    session[:user_id] = users(:michi).id
    get :index
    assert_response :success
    assert_template layout: 'layouts/application'
  end
end
