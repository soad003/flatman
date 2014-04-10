require 'test_helper'

class RessourceTest < ActiveSupport::TestCase
    test "do not save a resource without name" do
     resource = Ressource.new(startDate: Date.new, unit: "kw/h", startValue: 0, pricePerUnit: 1)
     assert_not  resource.save
    end

    test "do not save a resource without startDate" do
     resource = Ressource.new(name: "test", unit: "kw/h", startValue: 0, pricePerUnit: 1)
     assert_not  resource.save
    end

    test "do not save a resource without unit" do
     resource = Ressource.new(name: "test", startDate: Date.new, startValue: 0, pricePerUnit: 1)
     assert_not  resource.save
    end

    test "do not save a resource without startValue" do
     resource = Ressource.new(name: "test", startDate: Date.new, unit: "kw/h", pricePerUnit: 1)
     assert_not  resource.save
    end

    test "do not save a resource without a pricePerUnit" do
     resource = Ressource.new(name: "test", startDate: Date.new, unit: "kw/h", startValue: 0)
     assert_not  resource.save
    end

    test "do not save a resource without a negative pricePerUnit" do
     resource = Ressource.new(name: "test", startDate: Date.new, unit: "kw/h", startValue: 0, pricePerUnit: -1)
     assert_not  resource.save
    end

    test "save a resource" do
     resource = Ressource.new(name: "test", startDate: Date.new, unit: "kw/h", startValue: 0, pricePerUnit: 1)
     assert  resource.save
    end

    test "get_months" do
     date = Date.new(2000,10,10)

     assert (Ressource.get_months(date) == 24010) #2000*12 + 10 = 24010
    end

    test "get_month_diff" do
     	date1 = Date.new(2000,10,10)
	 	date2 = Date.new(2001,4,10)
     	date3 = Date.new(2000,1,10)
     	assert (Ressource.get_month_diff(date2, date1) == -6)
     	assert (Ressource.get_month_diff(date1, date2) ==  6)
     	assert (Ressource.get_month_diff(date3, date1) == 9)
    end

    test "get_resource_entries" do
        resource = Ressource.new(name: "test", startDate: Date.new, unit: "kw/h", startValue: 0, pricePerUnit: 1, monthlyCost: 10, annualCost: 100)

        re1 = Ressourceentry.new(date: Date.new(2013, 12, 10), value:100)
        re2 = Ressourceentry.new(date: Date.new(2014, 1, 10), value:250)
        re3 = Ressourceentry.new(date: Date.new(2014, 4, 10), value:400)

        resource.ressourceentries << re2
        resource.ressourceentries << re1
        resource.ressourceentries << re3
        resource.save!

        entries = Ressource.get_resource_entries(Date.new(2014,1,1), Date.new(2014,12,31), resource)
        assert (entries.size == 2)
        entries = Ressource.get_resource_entries(Date.new(2012,1,1), Date.new(2014,12,31), resource)
        assert (entries.size == 3)
        entries = Ressource.get_resource_entries(Date.new(2011,1,1), Date.new(2011,12,31), resource)
        assert (entries.size == 0)
    end

    test "get_resource_entry_before" do
        resource = Ressource.new(name: "test", startDate: Date.new, unit: "kw/h", startValue: 0, pricePerUnit: 1, monthlyCost: 10, annualCost: 100)

        re1 = Ressourceentry.new(date: Date.new(2013, 12, 10), value:100)
        re2 = Ressourceentry.new(date: Date.new(2014, 1, 10), value:250)
        re3 = Ressourceentry.new(date: Date.new(2014, 4, 10), value:400)

        resource.ressourceentries << re2
        resource.ressourceentries << re1
        resource.ressourceentries << re3
        resource.save!

        entry = Ressource.get_resource_entry_before(Date.new(2014,1,1), resource)
        assert (entry.value == 100)
        entry = Ressource.get_resource_entry_before(Date.new(2012,1,1), resource)
        assert (entry == nil)
        entry = Ressource.get_resource_entry_before(Date.new(2015,1,1), resource)
        assert (entry.value == 400)
    end

    test "get_resource_entry_after" do
        resource = Ressource.new(name: "test", startDate: Date.new, unit: "kw/h", startValue: 0, pricePerUnit: 1, monthlyCost: 10, annualCost: 100)

        re1 = Ressourceentry.new(date: Date.new(2013, 12, 10), value:100)
        re2 = Ressourceentry.new(date: Date.new(2014, 1, 10), value:250)
        re3 = Ressourceentry.new(date: Date.new(2014, 4, 10), value:400)

        resource.ressourceentries << re2
        resource.ressourceentries << re1
        resource.ressourceentries << re3
        resource.save!

        entry = Ressource.get_resource_entry_after(Date.new(2014,1,1), resource)
        assert (entry.value == 250)
        entry = Ressource.get_resource_entry_after(Date.new(2012,1,1), resource)
        assert (entry.value == 100)
        entry = Ressource.get_resource_entry_after(Date.new(2015,1,1), resource)
        assert (entry == nil)
    end

    test "get_resource_inkl_after_and_before" do
        resource = Ressource.new(name: "test", startDate: Date.new, unit: "kw/h", startValue: 0, pricePerUnit: 1, monthlyCost: 10, annualCost: 100)

        re1 = Ressourceentry.new(date: Date.new(2013, 12, 10), value:100)
        re2 = Ressourceentry.new(date: Date.new(2014, 1, 10), value:250)
        re3 = Ressourceentry.new(date: Date.new(2014, 4, 10), value:400)

        resource.ressourceentries << re2
        resource.ressourceentries << re1
        resource.ressourceentries << re3
        resource.save!

        entries = Ressource.get_resource_entries_inkl_after_and_before(Date.new(2014,3,3),Date.new(2014,3,4), resource)
        assert (entries.size == 2)
         entries = Ressource.get_resource_entries_inkl_after_and_before(Date.new(2011,3,3),Date.new(2011,3,4), resource)
        assert (entries.size == 1)
         entries = Ressource.get_resource_entries_inkl_after_and_before(Date.new(2013,12,12),Date.new(2014,3,4), resource)
        assert (entries.size == 3)
        
    end


end
