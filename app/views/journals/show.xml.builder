policy = @refable.policy || @refable.publisher.policy
xml.instruct!
xml.journal(href: url_for(@refable)) do
    xml.name @refable.name

    xml.aliases do
        @refable.entity_refs.each do |eref|
            xml.alias eref.refvalue
        end
    end

    xml.publisher(href: url_for(@refable.publisher)) do
        xml.name @refable.publisher.name
    end

    unless policy.nil?
        render(partial: 'policies/policy', :locals => {
            builder: xml,
            policy: policy
        })
    end
end