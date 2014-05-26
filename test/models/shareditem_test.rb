require 'test_helper'

class ShareditemTest < ActiveSupport::TestCase
   test "should not save shareditem without name" do
     item = Shareditem.new
     assert !item.save
   end
   
   test "should not save shareditem without a flat" do
     item = Shareditem.new
     item.name = "itemname"
     assert !item.save
   end
   
  test "create a shareditem" do
     item = Shareditem.new
     item.name = "itemname"
     item.flat=flats(:wg_michi)
     assert item.save
   end
   
   
end
