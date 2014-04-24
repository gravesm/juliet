builder.aliases do
    @refable.entity_refs.all.each do |eref|
        builder.alias eref.refvalue
    end
end