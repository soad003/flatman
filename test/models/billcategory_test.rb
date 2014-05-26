require 'test_helper'

class BillcategoryTest < ActiveSupport::TestCase
   test "do not save a billcategory without name" do
     billcat = Billcategory.new(flat_id: 1)
     assert_not billcat.save
    end

    test "do not save a billcategory without flat_id" do
     billcat = Billcategory.new(name: "Test")
     assert_not billcat.save
   	end
end
