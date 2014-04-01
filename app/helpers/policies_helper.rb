module PoliciesHelper
    def policy_to_json(policy)
        if policy
            {
                type: policy.policyable_type,
                parent: url_for(policy.policyable),
                href: url_for([policy.policyable, policy]),
                contact: policy.contact,
                embargo: policy.embargo,
                method_of_acquisition: policy.method_of_acquisition,
                note: policy.note,
                should_request_opt_out_papers: policy.should_request,
                opt_out_required: policy.opt_out_required,
                special_message: policy.message
            }
        end
    end
end