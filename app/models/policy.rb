class Policy < ActiveRecord::Base
    attr_accessible :contact, :embargo, :harvest_method, :harvestable, :note,
        :requirements, :policyable
    belongs_to :policyable, :polymorphic => true
end
