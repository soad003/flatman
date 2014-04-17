require 'test_helper'

class Api::ShoppingitemControllerTest < ActionController::TestCase
  include AssertJson
  include Login

  test "should not get data without login" do
    must_login('json')
  end

  test "destroy should make less items" do
    login_as_michi
    list = shoppinglists(:groceries_wg_michi)
    item = list.shoppinglistitems[0]
    assert_difference('Shoppinglistitem.count',-1) do
      delete :destroy, {format: "json",id: item.id,shoppinglist_id:list.id }
    end

    assert_response :success
    assert_empty response.body
  end

  test "update should return valid item" do
    login_as_michi
    list = shoppinglists(:groceries_wg_michi)
    item = list.shoppinglistitems[0]
    put :update, {format: "json",id: item.id, shoppinglist_id:list.id, name: "abc", checked:true }
    assert_response :success
    assert_empty response.body
  end

  test "create should return valid item" do
    login_as_michi
    list = shoppinglists(:groceries_wg_michi)
    assert_difference('Shoppinglistitem.count',1) do
        post :create, {format: "json", shoppinglist_id:list.id, name: "abc", checked:true }
    end
    assert_response :success
    assert_json(@response.body) do
        has 'id'
        has 'name'
        has 'checked'
    end
  end

end
