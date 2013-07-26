class EntityRef < ActiveRecord::Base
    attr_accessible :refvalue, :refable, :ref_type
    belongs_to :refable, polymorphic: true
    belongs_to :ref_type

    validates :refable, presence: true
    validates :refable_type, presence: true
    validates :ref_type, presence: true
    validates :refvalue,
        uniqueness: { case_sensitivity: false }, presence: true

    def self.publishers
        where(refable_type: "Publisher").group('refable_id')
    end

    def self.journals
        where(refable_type: "Journal").group('refable_id')
    end
end