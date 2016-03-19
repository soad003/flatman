require 'test_helper'

class ShoppinglistTest < ActiveSupport::TestCase
  test 'should not save shoppinglist without name' do
    list = Shoppinglist.new
    assert !list.save
  end

  test 'should not save shoppinglist without flat' do
    list = Shoppinglist.new(name: 'abc')
    assert !list.save
  end

  test 'should save valid shoppinglist' do
    list = Shoppinglist.new(name: 'abc')
    list.flat = flats(:wg_michi)
    assert list.save
  end

  test 'should find list from own wg' do
    wg_michi_list = shoppinglists(:groceries_wg_michi)
    user = users(:michi)
    list = Shoppinglist.find_list_with_user_constraint(wg_michi_list.id, user)
    assert list == wg_michi_list
  end

  test 'should not find list from other wg' do
    wg_michi_list = shoppinglists(:groceries_wg_michi)
    user = users(:clemi)
    assert_raises ActiveRecord::RecordNotFound do
      Shoppinglist.find_list_with_user_constraint(wg_michi_list.id, user)
    end
  end
end
