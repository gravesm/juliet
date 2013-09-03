class Policy < ActiveRecord::Base

    METHODS = ['SWORD', 'HARVEST', 'INDIVIDUAL_DOWNLOAD', 'RECRUIT_FROM_AUTHOR']

    validates :method_of_acquisition, inclusion: { in: METHODS },
        allow_blank: true

    attr_accessible :contact, :embargo, :method_of_acquisition, :note,
        :requirements, :opt_out_required, :should_request, :message, :policyable
    belongs_to :policyable, :polymorphic => true

    def method_of_acquisition
        read_attribute(:method_of_acquisition)
    end

    def method_of_acquistion=(value)
        write_attribute(:method_of_acquisition)
    end
end
