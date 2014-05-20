require 'test_helper'













class FinanceTest < ActiveSupport::TestCase
	def self.setupTest ()
		user1 = User.new(name: "user1", provider:"provider", uid:"uid", oauth_token:"oauthtoken", email:"email")
		user2 = User.new(name: "user2", provider:"provider", uid:"uid", oauth_token:"oauthtoken", email:"email")
		user3 = User.new(name: "user3", provider:"provider", uid:"uid", oauth_token:"oauthtoken", email:"email")
		user4 = User.new(name: "user4", provider:"provider", uid:"uid", oauth_token:"oauthtoken", email:"email")
		flat = Flat.new(name:"testFlat", street:"street", city:"city", zip:"zip")
		flat.users << user1
		flat.users << user2
		flat.users << user3
		flat.users << user4
		flat.save!
		payment1 = Payment.new(payer_id: user1.id, payee_id: user2.id, value: 150, date: Date.today)
		payment1.save!
		payment2 = Payment.new(payer_id: user1.id, payee_id: user3.id, value: 200, date: Date.today)
		payment2.save!
		payment3 = Payment.new(payer_id: user2.id, payee_id: user4.id, value: 50, date: Date.today)
		payment3.save!
		payment4 = Payment.new(payer_id: user3.id, payee_id: user1.id, value: 100, date: Date.today)
		payment4.save!
		payment5 = Payment.new(payer_id: user2.id, payee_id: user3.id, value: 75, date: Date.today)
		payment5.save!
		bill1 = Bill.new(user_id: user1.id, text:"bill1", value: 200, date: Date.today)
		bill1.users << user1
		bill1.users << user2
		bill1.users << user3
		bill1.users << user4
		bill1.save!

		bill2 = Bill.new(user_id: user2.id, text: "bill2", value: 50, date: Date.today)
		bill2.users << user3
		bill2.users << user4
		bill2.save!

		bill3 = Bill.new(user_id: user3.id, text: "bill3", value: 100, date: Date.today)
		bill3.users << user4
		bill3.save!

		bill4 = Bill.new(user_id: user4.id, text: "bill4", value: 300, date: Date.today)
		bill4.users << user2
		bill4.users << user3
		bill4.users << user4
		bill4.save!
	end


	test "finance list" do
		setupTest
     
    end

end
