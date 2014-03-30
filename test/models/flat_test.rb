require 'test_helper'

class FlatTest < ActiveSupport::TestCase
   test "testi" do
     assert true
   end
   
   test "create flat without properties" do
     flat = Flat.new
     assert !flat.save, "not allowed to create flat without name, street and zip"
   end

  
end
