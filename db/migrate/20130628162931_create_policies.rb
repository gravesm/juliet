class CreatePolicies < ActiveRecord::Migration
    def change
        create_table :policies do |t|
            t.text :contact
            t.text :note
            t.integer :embargo
            t.text :requirements
            t.boolean :harvestable
            t.string :harvest_method # Individual, Author
            t.references :policyable, :polymorphic => true
            t.timestamps
        end
        add_index :policies, :policyable_id
    end
end
