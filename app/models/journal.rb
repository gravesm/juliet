class Journal < ActiveRecord::Base
    include Nameable
    has_many :entity_refs, as: :refable, :dependent => :destroy
    has_one :policy, :as => :policyable, :dependent => :destroy
    belongs_to :publisher

    validates :publisher, presence: true

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
