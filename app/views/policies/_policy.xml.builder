builder.policy(
        href: url_for([policy.policyable, policy]),
        owner: url_for(policy.policyable)) do
    builder.type policy.policyable_type
    builder.contact policy.contact
    builder.embargo policy.embargo
    builder.methodOfAcquisition policy.method_of_acquisition
    builder.note policy.note
    builder.shouldRequestOptOutPapers policy.should_request
    builder.optOutRequired policy.opt_out_required
    builder.specialMessage policy.message
end