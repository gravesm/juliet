xml.instruct!
xml.response do
    xml.results @refable.nil? ? 0 : 1
    unless @refable.nil?
        xml.result do
            if @refable.respond_to? :publisher
                render(:partial => 'journals/journal', :locals => { builder: xml })
            else
                render(:partial => 'publishers/publisher', :locals => { builder: xml })
            end
        end
    end
end