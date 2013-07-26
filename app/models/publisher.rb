class Publisher < ActiveRecord::Base
    attr_accessible :note, :name, :journals

    has_many :entity_refs, :as => :refable
    has_one :policy, :as => :policyable
    has_many :journals

    def self.by_name(name)
        includes(:entity_refs).where(
            "entity_refs.refvalue LIKE ? OR publishers.name LIKE ?", name, name)
    end
end
