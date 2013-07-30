class RefType < ActiveRecord::Base
  attr_accessible :type_name

  has_many :entity_refs
end
