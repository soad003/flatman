require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "invite" do
    user=users(:michi)
    # Send the email, then test that it got queued
    email = UserMailer.invite(user.email,
                                     user.flat.name).deliver
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [user.email], email.to
   #assert_equal read_fixture('invite').join, email.body.to_s
  end

  test "added to flat" do
    user=users(:michi)
    # Send the email, then test that it got queued
    email = UserMailer.added_to_flat(user).deliver
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [user.email], email.to
   #assert_equal read_fixture('invite').join, email.body.to_s
  end

end
