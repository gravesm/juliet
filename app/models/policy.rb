class Policy < ActiveRecord::Base

    METHODS = ['SWORD', 'HARVEST', 'INDIVIDUAL_DOWNLOAD', 'RECRUIT_FROM_AUTHOR_FPV',
        'RECRUIT_FROM_AUTHOR_MANUSCRIPT']

    validates :method_of_acquisition, inclusion: { in: METHODS },
        allow_blank: true

    belongs_to :policyable, :polymorphic => true

end
