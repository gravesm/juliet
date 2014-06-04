require 'unique_name_validator'

class Publisher < ActiveRecord::Base
    attr_accessible :note, :name, :journals

    has_many :entity_refs, :as => :refable, :dependent => :destroy
    has_one :policy, :as => :policyable, :dependent => :destroy
    has_many :journals, :dependent => :destroy

    validates :name, presence: true, unique_publisher: true

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
