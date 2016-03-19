require 'test_helper'

class ShoppinglistitemTest < ActiveSupport::TestCase
  test 'should not save shoppinglist_item without name' do
    list_item = Shoppinglistitem.new
    list_item.shoppinglist = shoppinglists(:groceries_wg_michi)
    assert !list_item.save
  end

  test 'should save shoppinglist_item with name and list' do
    list_item = Shoppinglistitem.new(name: 'bla', checked: false)
    list_item.user = users(:michi)
    list_item.shoppinglist = shoppinglists(:groceries_wg_michi)
    assert list_item.save
  end

  test 'should not save shoppinglist_item without list' do
    list_item = Shoppinglistitem.new(name: 'bla')
    assert !list_item.save
  end

  test 'should find item from own wg' do
    wg_michi_item = shoppinglistitems(:butter)
    user = users(:michi)
    list_item = Shoppinglistitem.find_with_user_constraint(wg_michi_item.id, wg_michi_item.shoppinglist.id, user)
    assert list_item == wg_michi_item
  end

  test 'should not find item from other wg' do
    wg_michi_item = shoppinglistitems(:butter)
    user = users(:clemi)
    assert_raises ActiveRecord::RecordNotFound do
      Shoppinglistitem.find_with_user_constraint(wg_michi_item.id, wg_michi_item.shoppinglist.id, user)
    end
  end
end
