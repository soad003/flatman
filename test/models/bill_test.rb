require 'test_helper'

class BillTest < ActiveSupport::TestCase
   test "do not save a bill without name" do
     bill = Bill.new(date: Date.new,  value: 10, user_id: 1, billcategory_id: 2)
     assert_not bill.save
    end

   test "do not save a bill without user_id" do
     bill = Bill.new(date: Date.new, value: 10, billcategory_id: 2, text: "test")
     assert_not bill.save
    end

   test "do not save a bill without value" do
     bill = Bill.new(date: Date.new, user_id: 1, billcategory_id: 2, text: "test")
     assert_not bill.save
    end

    test "do not save a bill without billcategory_id" do
     bill = Bill.new(date: Date.new, user_id: 1, value: 10, text: "test")
     assert_not bill.save
    end

    test "do not save a bill without date" do
     bill = Bill.new(value: 10, user_id: 1, billcategory_id: 2, text: "test")
     assert_not bill.save
    end
end
