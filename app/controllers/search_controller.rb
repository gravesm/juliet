class SearchController < ApplicationController
    include RefablesHelper
    before_filter :do_query

    def index
        if params[:query]
            @journal = Journal.by_name(params[:query]).group('journals.id').first
        end
    end

    def search
        json = {
            :response => {
                :type => params[:type],
                :query => params[:query],
                :results => @result ? 1 : 0
            }
        }
        if @result
            json[:result] = refable_to_json(@result)
            render json: json
        end
    end

    private
        def do_query
            if params.has_key?(:query)
                if params[:type] == "journal"
                    @result = Journal.by_name(params[:query]).
                        group('journals.id').first
                elsif params[:type] == "publisher"
                    @result = Publisher.by_name(params[:query]).
                        group('publishers.id').first
                end
            end
        end
end