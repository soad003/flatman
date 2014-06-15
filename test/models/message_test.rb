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
    	cle.flat_id = "3"
    	assert Message.find_chats(cle).length == 3
    	assert Message.find_chats(chri).length == 3
    	assert Message.find_chats(pferd).length == 2
    end

    test "countUnread" do
    	messList = Message.find_messages(messages(:one).id, users(:chrisi), 20)
    	messList2 = Message.find_messages(messages(:four).id, users(:clemi), 20)
    	assert Message.countUnread(messList, users(:chrisi)) == "1"
    	assert Message.countUnread(messList2, users(:clemi)) == "0"
    end

    test "countFlatChatUnread" do
    	messList = Message.where(header: "flatchat3")
    	assert Message.countFlatChatUnread(messList, users(:chrisi)) == "2"
    	assert Message.countFlatChatUnread(messList, users(:clemi)) == "2"
    end

    test "getFlatChat" do
    	chri = users(:chrisi)
    	cle = users(:clemi)
    	pferd = users(:niko)
    	cle.flat_id = "3"
    	pferd.flat_id = "3"
    	assert Message.getFlatChat(chri).text == "hello8"
    	assert Message.getFlatChat(chri).id == 8
    	assert Message.getFlatChat(cle).id == 8
    	assert Message.getFlatChat(pferd).id == 8
    end

    test "createMessages" do
    	mesparams1 = ({receiver_id: 1, sender_id: 2, header: "4, 1", text: "hello9"})
    	messageRec1 = [1, 4]
    	mesparams2 = ({receiver_id: 2, sender_id: 4, header: "2, 1", text: "hello10"})
    	messageRec2 = [2, 1]
    	mesparams3 = ({receiver_id: 1, sender_id: 1, header: "flatchat", text: "hello11"})
    	messageRec3 = ["flatchat"]
    	chrisi = users(:chrisi)
    	assert Message.createMessages(messageRec1, users(:niko), mesparams1)
    	assert Message.createMessages(messageRec2, users(:clemi), mesparams2)
    	assert Message.createMessages(messageRec3, users(:chrisi), mesparams3)
    	assert Message.find_messages(messages(:one).id, users(:niko), 20).last.text == "hello9"
    	assert Message.find_messages(messages(:five).id, users(:clemi), 20).last.text == "hello10"
    	assert Message.find_messages(messages(:seven).id, chrisi, 20).last.text == "hello11"
	end

	test "calcTime" do
		assert Message.calcTime().to_i == Time.now.to_i + 3600 || Message.calcTime().to_i == Time.now.to_i + 7200
	end

	test "destroyMessages" do
		assert Message.destroyMessages(messages(:one).id, users(:chrisi))
		assert Message.find(messages(:one)).id == 1
		assert Message.find(messages(:one)).deleted.include?(users(:chrisi).id)
		assert Message.destroyMessages(messages(:one).id, users(:niko))
		assert Message.find_by_id(messages(:one).id) == nil
	end
end
