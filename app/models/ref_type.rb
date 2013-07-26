class RefType < ActiveRecord::Base
  attr_accessible :type

  has_many :entity_refs
end
