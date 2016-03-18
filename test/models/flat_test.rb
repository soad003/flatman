require 'test_helper'

class FlatTest < ActiveSupport::TestCase

    test "create flat without properties" do
     flat = Flat.new
     assert !flat.save, "not allowed to create flat without name, street and zip"
    end

    test "should not create flat without name" do
     flat = Flat.new(street: "abc", zip: "abc", city: "dbb")
     assert !flat.save, "not allowed to create flat without name"
    end

    test "should not create valid flat" do
     user=users(:michi)
     flat = Flat.create_with_user!(user,{street: "abc",zip: "abc", city: "abc", name: "dbb"})
     assert !flat.created_at.nil?
    end

    test "is michi member" do
     flat= flats(:wg_michi)
     assert flat.is_member? users(:michi)
    end

    test "is niko not member" do
     flat= flats(:wg_michi)
     assert !flat.is_member?( users(:niko))
    end

    test "add user works adds user" do
     flat= flats(:wg_michi)
     user=users(:niko)
     assert flat.add_user(user)
     assert user.flat==flat
    end


    test "should not be possible to make multiple flats with same name" do
     flat_old= flats(:wg_michi)
     flat=Flat.new({street: "abc",zip: "abc", city: "abc"})
     flat.name=flat_old.name

     #ActiveRecord::RecordNotUnique

     assert !flat.save
    end


end
