builder.journal(href: url_for(@refable)) do
    builder.name @refable.name

    render(partial: 'entity_refs/entity_ref', :locals => { builder: builder })

    builder.publisher(href: url_for(@refable.publisher)) do
        builder.name @refable.publisher.name
    end

    policy = @refable.policy || @refable.publisher.policy
    unless policy.nil?
        render(partial: 'policies/policy', :locals => {
            builder: builder,
            policy: policy
        })
    end
end