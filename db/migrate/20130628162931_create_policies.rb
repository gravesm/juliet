class CreatePolicies < ActiveRecord::Migration
    def change
        create_table :policies do |t|
            t.text :contact
            t.text :note
            t.integer :embargo
            t.text :requirements
            t.string :method_of_acquisition
            t.boolean :opt_out_required
            t.boolean :should_request
            t.text :message
            t.references :policyable, :polymorphic => true
            t.timestamps
        end
        add_index :policies, :policyable_id
    end
end
