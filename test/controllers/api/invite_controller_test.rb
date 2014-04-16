require 'test_helper'

class Api::InviteControllerTest < ActionController::TestCase
  include AssertJson
  include Login

  test "should not get data without login" do
    must_login('json')
  end

  test "destroy should make less invites" do
    login_as_michi
    assert_difference('Invite.count',-1) do
      delete :destroy, {format: "json",id: invites(:wg_michi_one).id }
    end

    assert_response :success
  end

  test "destroy with wrong id should return not found" do
    login_as_michi
    assert_no_difference('Invite.count') do
      delete :destroy, {format: "json",id: 0 }
    end

    assert_response :not_found
  end

  test "create invite for user email not in system" do
    login_as_michi
    unlikely_mail="no@no.no"
    assert_difference('Invite.count',1) do
      post :create, {format: "json",email: unlikely_mail }
    end
    assert_response :success
    assert_json(@response.body) do
      has 'already_registred' , false
      has 'invite'do
        has 'email', unlikely_mail
        has 'id'
      end
    end
  end

  test "create invite for user email already in flat" do
    login_as_michi
    user_with_flat_mail = users(:michi).email
    assert_no_difference('Invite.count') do
        post :create, {format: "json",email: user_with_flat_mail }
    end
    assert_response :unprocessable_entity
  end

  test "create invite for user email in system and without flat" do
    login_as_michi
    user_with_no_flat_mail = users(:niko).email
    assert_no_difference('Invite.count') do
        post :create, {format: "json",email: user_with_no_flat_mail }
    end
    assert_response :success
    assert_json(@response.body) do
      has 'already_registred' , true
      has 'user'do
        has 'name'
        has 'id'
      end
    end
  end
end
