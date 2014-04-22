xml.instruct!
xml.publisher(href: url_for(@refable)) do
    xml.name @refable.name

    xml.aliases do
        @refable.entity_refs.each do |eref|
            xml.alias eref.refvalue
        end
    end

    unless @refable.policy.nil?
        render(partial: 'policies/policy', :locals => {
            builder: xml,
            policy: @refable.policy
        })
    end
end