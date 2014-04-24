builder.publisher(href: url_for(@refable)) do
    builder.name @refable.name

    render(partial: 'entity_refs/entity_ref', :locals => { builder: builder })

    unless @refable.policy.nil?
        render(partial: 'policies/policy', :locals => {
            builder: builder,
            policy: @refable.policy
        })
    end
end