class Publisher < ActiveRecord::Base
    attr_accessible :note, :name, :journals

    has_many :entity_refs, :as => :refable
    has_one :policy, :as => :policyable
    has_many :journals

    validates :name, presence: true, uniqueness: { case_sensitivity: false }

    def self.by_name(name)
        includes(:entity_refs).where(
            "entity_refs.refvalue LIKE ? OR publishers.name LIKE ?", name, name)
    end

    searchable do
        text :name
        string :name_sortable do
            name.downcase.gsub(/^the/, '').strip
        end
        text :entity_refs do
            entity_refs.map(&:refvalue)
        end
    end
end
