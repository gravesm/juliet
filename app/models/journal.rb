class Journal < ActiveRecord::Base
    attr_accessible :note, :name, :publisher

    has_many :entity_refs, as: :refable
    has_one :policy, :as => :policyable
    belongs_to :publisher

    validates :publisher, presence: true
    validates :name, uniqueness: { case_sensitivity: false }, presence: true

    def self.by_name(name)
        includes(:entity_refs).where(
            "entity_refs.refvalue LIKE ? OR journals.name LIKE ?", name, name)
    end
end
