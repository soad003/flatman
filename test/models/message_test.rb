require 'test_helper'

class MessageTest < ActiveSupport::TestCase
	test "do not save a message without receiver_id" do
     message = Message.new({sender_id: 1, text: "hello", header: ""})
     assert_not  message.save
    end

    test "do not save a message without sender_id" do
     message = Message.new({receiver_id: 1, text: "hello", header: ""})
     assert_not  message.save
    end

    test "do not save a message without text" do
     message = Message.new({receiver_id: 1, sender_id: 2, header: ""})
     assert_not  message.save
    end

    test "save a message" do 
    	message = Message.new({receiver_id: 1, sender_id: 2, header: "", text: "hello"})
    	assert message.save
    end

    test "find_messages" do
    	chri = users(:chrisi)
    	assert Message.find_messages(messages(:one).id, chri, 20).length == 2
    	assert Message.find_messages(messages(:one).id, chri, 2).length == 2
    end

    test "find_partner" do
    	chri = users(:chrisi)
    	assert Message.find_partner(messages(:one).id, chri)[:id] == 2
    	assert Message.find_partner(messages(:two).id, chri)[:id] == 2
    	assert Message.find_partner(messages(:three).id, chri)[:id] == 1
    	assert Message.find_partner(messages(:three).id, chri)[:name] == chri.flat.name
    	assert Message.find_partner("0", chri)[:name] == chri.flat.name			# first flatchat message
    end

    test "find_chats" do
    	chri = users(:chrisi)
    	cle = users(:clemi)
    	pferd = users(:niko)
    	chri.flat_id = "3"
    	assert Message.find_chats(cle).length == 3
    	assert Message.find_chats(chri).length == 2
    	assert Message.find_chats(pferd).length == 2
    end

    test "countUnread" do
    	messList = Message.find_messages(messages(:one).id, users(:chrisi), 20)
    	messList2 = Message.find_messages(messages(:four).id, users(:clemi), 20)
    	assert Message.countUnread(messList, users(:chrisi)) == "1"
    	assert Message.countUnread(messList2, users(:clemi)) == "0"
    end
end
