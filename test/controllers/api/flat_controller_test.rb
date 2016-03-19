require 'test_helper'

class Api::FlatControllerTest < ActionController::TestCase
  include AssertJson
  include Login

  test 'should not get data without login' do
    must_login('json')
  end

  test 'should get index and respose has valid format' do
    login_as_michi
    get :index, format: 'json'
    assert_response :success
    assert_flat_with_invite_and_users_return
  end

  test 'should not create if has flat' do
    login_as_michi
    assert_no_difference('Flat.count') do
      put :create, format: 'json', name: 'sdf', city: 'salf', street: 'dasd', zip: 'dd'
    end
    assert_response :unprocessable_entity
  end

  test 'should create if has no flat' do
    login_as_niko
    assert_difference('Flat.count', 1) do
      put :create, format: 'json', name: 'sdf', city: 'salf', street: 'dasd', zip: 'dd'
    end
    assert_response :success
  end

  test 'update should return valid flat' do
    login_as_michi
    post :update, format: 'json', name: 'sdf', city: 'salf', street: 'dasd', zip: 'dd'
    assert_response :success
    assert_json(@response.body) do
      has 'name'
      has 'id'
      has 'street'
      has 'city'
      has 'zip'
      has_not 'users'
      has_not 'invites'
    end
  end

  def assert_flat_with_invite_and_users_return
    assert_json(@response.body) do
      has 'name'
      has 'id'
      has 'street'
      has 'city'
      has 'zip'
      has 'users' do
        item 0 do
          has 'id'
          has 'name'
        end
      end
      has 'invites' do
        item 0 do
          has 'id'
          has 'email'
        end
      end
    end
  end
end
