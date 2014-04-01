class Ressourceentry < ActiveRecord::Base
	belongs_to	:ressource
	attr_accessor :costs
	attr_accessor :usage
    validates   :date, presence: true
    validates_numericality_of  :value, :greater_than => 0

	def self.find_with_user_constraint(id, r_id, user)
            r = Ressource.find_resource_with_user_constraint(r_id, user)
            r.ressourceentries.where(id:id).first
    end

	def self.destroy_with_user_constraint(id, r_id, user)
            item = Ressourceentry.find_with_user_constraint(id, r_id, user)
            item.destroy!
    end
end
