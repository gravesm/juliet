module RefablesHelper
    include PoliciesHelper
    def refable_to_json(refable)
        ref = {
            name: refable.name,
            aliases: refable.entity_refs.load.map(&:refvalue),
            href: url_for(refable)
        }

        if refable.respond_to? :publisher
            ref['publisher'] = {
                name: refable.publisher.name,
                href: url_for(refable.publisher)
            }
        end

        if !refable.policy.nil?
            ref['policy'] = policy_to_json refable.policy
        elsif refable.respond_to? :publisher
            ref['policy'] = policy_to_json refable.publisher.policy
        end

        return ref
    end
end