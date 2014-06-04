class SearchController < ApplicationController
    include RefablesHelper
    before_filter :do_query

    def index
        if params[:query]
            @journal = Journal.by_name(params[:query]).group('journals.id').first
        end
    end

    def search
        respond_to do |format|
            format.json {
                json = {
                    :response => {
                        :type => params[:type],
                        :query => params[:query],
                        :results => @refable ? 1 : 0
                    }
                }
                unless @refable.nil?
                    json[:result] = refable_to_json(@refable)
                end
                render json: json
            }
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