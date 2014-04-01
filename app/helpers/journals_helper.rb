module JournalsHelper
    include PoliciesHelper
    def journal_to_json(journal)
        {
            name: journal.name,
            publisher: {
                name: journal.publisher.name,
                href: url_for(journal.publisher)
            },
            aliases: journal.entity_refs.all.map(&:refvalue),
            href: url_for(journal),
            policy: policy_to_json(journal.policy || journal.publisher.policy)
        }
    end
end
