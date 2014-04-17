require 'test_helper'

class Api::ShoppinglistControllerTest < ActionController::TestCase
  include AssertJson
  include Login

  test "should not get data without login" do
    must_login('json')
  end

  test "should get index and respose has valid format" do
    login_as_michi
    get :index, :format => 'json'
    assert_response :success
    assert_json(@response.body) do
     item 0 do
      has 'id'
      has 'name'
      has 'items' do
        has 'id'
        has 'name'
        has 'checked'
      end
     end
    end
  end

  test "should create list and get valid response" do
    login_as_michi
    listname="bla bla"
    assert_difference('Shoppinglist.count',1) do
      post :create, {format: "json",name: listname }
    end
    assert_response :success
    assert_json(@response.body) do
        has 'id'
        has 'name', listname
    end
  end

  test "should destory list" do
    login_as_michi
    list_id=shoppinglists(:groceries_wg_michi).id
    assert_difference('Shoppinglist.count',-1) do
      delete :destroy, {format: "json",id: list_id }
    end
    assert_response :success
    assert_empty response.body
  end

  test "should not destory list other flat" do
    login_as_michi
    list_id=shoppinglists(:groceries_wg_cle).id
    assert_no_difference('Shoppinglist.count') do
      delete :destroy, {format: "json",id: list_id }
    end
    assert_response :not_found
  end
end
