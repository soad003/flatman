require 'test_helper'

class Api::MessageControllerTest < ActionController::TestCase
	include AssertJson
	include Login

	test "index" do 
		login_as_hans
		get :index, :format => 'json'
		assert_response :success
		assert_index
	end

	test "get_messages" do
		login_as_chri
		get :get_messages, {:format => 'json', id: 1, quantity: 20}
		assert_response :success
		assert_get_messages
	end

	test "get_messages flatchat" do
		login_as_chri
		get :get_messages, {:format => 'json', id: 8, quantity: 20}
		assert_response :success
		assert_get_messages_flatchat
	end

	test "getFlatChat" do
		login_as_chri
		get :getFlatChat, :format => 'json'
		assert_response :success
		assert_getFlatChat
	end

	test "find_partner" do
		login_as_chri
		get :find_partner, {:format => 'json', mes_id: 1}
		assert_response :success
		assert_json(@response.body) do
        	has 'id', 2
        	has 'name', "Niko Risslegger"
    	end
	end

	test "find_active_chat" do
		login_as_chri
		get :find_active_chat, {:format => 'json', mes_id: 1, option: "option"}
		assert_response :success
		assert_json(@response.body) do
			has 'active', false
		end
	end

	test "find_active_chat flatchat" do
		login_as_chri
		get :find_active_chat, {:format => 'json', mes_id: 3, option: "option"}
		assert_response :success
		assert_json(@response.body) do
			has 'active', true
		end
	end

	test "find_active_chat if no flatchat message exists" do
		login_as_chri
		get :find_active_chat, {:format => 'json', mes_id: 0, option: "option"}
		assert_response :success
		assert_json(@response.body) do
			has 'active', true
		end
	end

	test "getUserId" do
		login_as_chri
		get :getUserId, {:format => 'json'}
		assert_response :success
		assert_json(@response.body) do
			has 'id', 1
		end
	end

	test "getFlatMembers" do
		login_as_chri
		get :getFlatMembers, {:format => 'json', flat_id: 3}
		assert_response :success
		assert_json(@response.body) do
          	has 'users' do
          		item 1 do
          			has 'text', "raffi"
          			has 'id', 5
          		end
          	end
		end
	end

	test "create" do
		login_as_chri
		post :create, {:format => 'json', receiver_id: 2, sender_id: 1, header: "2", text: "hello10"}
		assert_response :success
		assert_create
	end

	test "get_users" do
		login_as_chri
		get :get_users, {:format => 'json'}
		assert_response :success
		assert_get_users
	end

	test "destroy" do
		login_as_chri
		delete :destroy, {:format => 'json', id: 1}
		assert_response :success
		assert_destroy
	end

	test "count_messages" do
		login_as_chri
		get :count_messages, {:format => 'json', mes_id: 1}
		assert_response :success
		assert_count_messages
	end

	test "count_messages flatchat" do
		login_as_chri
		get :count_messages, {:format => 'json'}
		assert_response :success
		assert_count_messages_flatchat
	end

	def assert_index 
		assert_json(@response.body) do
			item 0 do
				has 'id', 9
				has 'sender_id', 6
				has 'text', "hello9"
				has 'receiver_id', 1
				has 'header'
				has 'flat_name', "Chri WG"
				has 'time'
				has 'sender_name', "hans"
				has 'receiver_name', "Schöpfi"
				has 'partner', "Schöpfi"
				has 'partner_id', 1
			end
		end
	end

	def assert_get_messages
		assert_json(@response.body) do
			item 0 do  
				has 'id', 1
				has 'sender_id', 2
				has 'text', "hello1"
				has 'receiver_id', 1
				has 'created_at'
				has 'sender_name', "Niko Risslegger"
				has 'receiver_name', "Schöpfi"
				has 'read', false
				has 'header'
				has 'updated_at'
			end
		end
	end

	def assert_get_messages_flatchat
		assert_json(@response.body) do
			item 0 do  
				has 'id', 3
				has 'sender_id', 1
				has 'text', "hello3"
				has 'receiver_id', 1
				has 'created_at'
				has 'sender_name', "Schöpfi"
				has 'receiver_name', "Schöpfi"
				has 'read', false
				has 'header'
				has 'updated_at'
			end
		end
	end

	def assert_getFlatChat
		assert_json(@response.body) do
			has 'id', 8
			has 'sender_id', 4
			has 'text', "hello8"
			has 'time'
			has 'sender_name', "Clemens Brunner"
			has 'header', "flatchat3"
			has 'flat_name', "Cle WG"
		end
	end

	def assert_create
		assert_json(@response.body) do
			item 0 do
				has 'id'
				has 'sender_name', "Schöpfi"
				has 'receiver_name', "Niko Risslegger"
				has 'text', "hello10"
				has 'sender_id', 1
				has 'receiver_id', 2
			end
		end
	end

	def assert_get_users
		assert_json(@response.body) do
			item 1 do
				has 'id', 4
				has 'name', "Clemens Brunner"
				has 'email', "cle@test.com"
				has 'uid', "1438808023"
				has 'flat_name', "Cle WG"
				has 'flat_id'
			end
		end
	end

	def assert_destroy
		assert Message.find(1).deleted.include?(1)
	end

	def assert_count_messages
		assert_json(@response.body) do
			has 'counter', "1"
		end
	end

	def assert_count_messages_flatchat
		assert_json(@response.body) do
			has 'counter', "2"
		end
	end
end