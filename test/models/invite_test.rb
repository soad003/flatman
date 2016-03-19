require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  test 'should not save invite without email' do
    inv = Invite.new
    inv.flat = flats(:wg_michi)
    assert !inv.save
  end

  test 'should not save invite without valid email' do
    inv = Invite.new(email: 'abc')
    inv.flat = flats(:wg_michi)
    assert !inv.save
  end

  test 'should not save invite without flat' do
    inv = Invite.new(email: 'abc@bca.at')
    assert !inv.save
  end

  test 'should save valid invite' do
    inv = Invite.new(email: 'abc@bca.at')
    inv.flat = flats(:wg_michi)
    assert inv.save
  end

  test 'should find niko1003@gmx.net' do
    inv = Invite.find_by_email 'niko1003@gmx.net'
    assert !inv.nil?
  end

  test 'should not find a.b@c.com' do
    inv = Invite.find_by_email 'a.b@c.com'
    assert inv.nil?
  end

  test 'should find invite from own wg' do
    wg_michi_inv = invites(:wg_michi_one)
    user = users(:michi)
    inv = Invite.find_with_user_constraint(wg_michi_inv.id, user)
    assert inv == wg_michi_inv
  end

  test 'should not find list from other wg' do
    wg_michi_inv = invites(:wg_michi_one)
    user = users(:clemi)
    assert_raises ActiveRecord::RecordNotFound do
      Invite.find_with_user_constraint(wg_michi_inv.id, user)
    end
  end
end
