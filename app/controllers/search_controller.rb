class SearchController < ApplicationController
    before_filter :do_query

    def index
        if params[:query]
            @journal = Journal.by_name(params[:query]).first
        end
    end

    def search
        respond_to do |format|
            format.json
            format.xml
        end
    end

    private
        def do_query
            if params.has_key?(:query)
                if params[:type] == "journal"
                    @refable = Journal.by_name(params[:query]).first
                elsif params[:type] == "publisher"
                    @refable = Publisher.by_name(params[:query]).first
                end
            end
        end
end