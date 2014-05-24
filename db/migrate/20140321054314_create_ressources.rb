class CreateRessources < ActiveRecord::Migration
  def change
    create_table :ressources do |t|
		  t.belongs_to 	:flat
    	t.string		:name
    	t.string		:unit
    	t.float			:pricePerUnit
    	t.float			:monthlyCost
    	t.float			:annualCost
    	t.float			:description	
    	t.float			:startValue
      t.timestamps
    end
  end
end
