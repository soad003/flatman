class Ressource < ActiveRecord::Base
		belongs_to	:flat
	has_many	:ressourceentries
end
