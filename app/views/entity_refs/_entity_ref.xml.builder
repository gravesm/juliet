builder.aliases do
    @refable.entity_refs.load.each do |eref|
        builder.alias eref.refvalue
    end
end