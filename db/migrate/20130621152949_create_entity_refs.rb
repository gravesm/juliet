class CreateEntityRefs < ActiveRecord::Migration
  def change
    create_table :entity_refs do |t|
      t.text :refvalue
      t.references :refable, :polymorphic => true
      t.belongs_to :ref_type
      t.timestamps
    end
    add_index :entity_refs, :refable_id
  end
end
