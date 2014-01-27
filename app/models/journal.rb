class Journal < ActiveRecord::Base
    attr_accessible :note, :name, :publisher, :publisher_id

    has_many :entity_refs, as: :refable, :dependent => :destroy
    has_one :policy, :as => :policyable, :dependent => :destroy
    belongs_to :publisher

    validates :publisher, presence: true
    validates :name, uniqueness: { case_sensitivity: false }, presence: true

    def self.by_name(name)
        includes(:entity_refs).where(
            "entity_refs.refvalue LIKE ? OR journals.name LIKE ?", name, name)
    end

    def as_json(options={})
        json = {
            name: self.name,
            publisher: {
                :name => self.publisher.name
            },
            aliases: self.entity_refs.all.map(&:refvalue)
        }
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
