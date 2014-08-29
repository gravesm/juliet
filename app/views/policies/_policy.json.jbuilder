json.type policy.policyable_type
json.parent url_for(policy.policyable)
json.href url_for([policy.policyable, policy])
json.contact policy.contact
json.embargo policy.embargo
json.method_of_acquisition policy.method_of_acquisition
json.note policy.note
json.should_request_opt_out_papers policy.should_request
json.opt_out_required policy.opt_out_required
json.special_message policy.message