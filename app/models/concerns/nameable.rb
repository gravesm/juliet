module Nameable
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validate if: Proc.new { |n| n.name_changed? } do
      errors.add(:name, "Name must be unique") unless
        self.class.by_name(name).empty?
    end

    scope :by_name, ->(name) {
      includes(entity_refs: :ref_type)
      .where(%Q{
        (lower(entity_refs.refvalue) LIKE lower(?)
          AND ref_types.type_name = 'Alias')
        OR lower(#{table_name}.name) LIKE lower(?)
        }, name, name
      )
      .references(:entity_refs, :ref_types)
    }
  end
end