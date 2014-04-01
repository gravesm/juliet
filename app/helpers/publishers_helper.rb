module PublishersHelper
    include PoliciesHelper
    def publisher_to_json(pub)
        {
            name: pub.name,
            aliases: pub.entity_refs.all.map(&:refvalue),
            href: url_for(pub),
            policy: policy_to_json(pub.policy)
        }
    end
end
