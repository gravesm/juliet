json.name refable.name
json.aliases refable.entity_refs.map(&:refvalue)
json.href url_for(refable)

if refable.respond_to? :publisher
  json.publisher do
    json.name refable.publisher.name
    json.href url_for(refable.publisher)
  end
end

if !refable.policy.nil?
  json.policy do
    json.partial! 'policies/policy', policy: refable.policy
  end
elsif refable.respond_to? :publisher
  json.policy do
    json.partial! 'policies/policy', policy: refable.publisher.policy
  end
end
