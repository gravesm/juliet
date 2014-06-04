require 'unique_name_validator'

class Journal < ActiveRecord::Base
    attr_accessible :note, :name, :publisher, :publisher_id

    has_many :entity_refs, as: :refable, :dependent => :destroy
    has_one :policy, :as => :policyable, :dependent => :destroy
    belongs_to :publisher

    validates :publisher, presence: true
    validates :name, presence: true, unique_journal: true

    def self.by_name(name)
        includes(:entity_refs).where(
            "lower(entity_refs.refvalue) LIKE lower(?) OR lower(journals.name) LIKE lower(?)",
            name, name)
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
