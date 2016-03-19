require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'invite' do
    user = users(:michi)
    # Send the email, then test that it got queued
    email = UserMailer.invite(user.email,
                              user.flat.name, '2P0BylDWfMoNn6aNShYmUg', 'POcMd8qAtwdF5O_2F5laeg').deliver
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [user.email], email.to
    # assert_equal read_fixture('invite').join, email.body.to_s
  end
end
