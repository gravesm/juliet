class EntityRef < ActiveRecord::Base
    belongs_to :refable, polymorphic: true
    belongs_to :ref_type

    validates :refable, presence: true
    validates :refable_type, presence: true
    validates :ref_type, presence: true
    validates :refvalue, presence: true
    validate unless: Proc.new { |r| r.refable.nil? } do
        errors.add(:refvalue, "Name must be unique") unless
            refable.class.by_name(refvalue).empty?
    end

    def self.publishers
        where(refable_type: "Publisher").group('refable_id')
    end

    def self.journals
        where(refable_type: "Journal").group('refable_id')
    end
end