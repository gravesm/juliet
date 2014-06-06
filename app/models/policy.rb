class Policy < ActiveRecord::Base

    METHODS = ['SWORD', 'HARVEST', 'INDIVIDUAL_DOWNLOAD', 'RECRUIT_FROM_AUTHOR_FPV',
        'RECRUIT_FROM_AUTHOR_MANUSCRIPT']

    validates :method_of_acquisition, inclusion: { in: METHODS },
        allow_blank: true

    attr_accessible :contact, :embargo, :method_of_acquisition, :note,
        :requirements, :opt_out_required, :should_request, :message, :policyable
    belongs_to :policyable, :polymorphic => true

end
