class Policy < ActiveRecord::Base
    attr_accessible :contact, :embargo, :harvest_method, :harvestable, :note,
        :requirements, :opt_out_required, :should_request, :message, :policyable
    belongs_to :policyable, :polymorphic => true
end
