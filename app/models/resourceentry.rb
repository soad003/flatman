class Resourceentry < ActiveRecord::Base
	belongs_to	:resource
	attr_accessor :costs
	attr_accessor :usage
    validates   :date, presence: true
    validates   :value, numericality: {greater_than_or_equal_to: 0}, presence: true

	def self.find_with_user_constraint(id, r_id, user)
            r = Resource.find_resource_with_user_constraint(r_id, user)
            r.resourceentries.where(id:id).first
    end

	def self.destroy_with_user_constraint(id, r_id, user)
            item = Resourceentry.find_with_user_constraint(id, r_id, user)
            item.destroy!
    end
end