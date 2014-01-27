class SearchController < ApplicationController

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
            res = @result.as_json
            res[:href] = url_for(@result)
            if @result.respond_to? :publisher
                res[:publisher][:href] = url_for(@result.publisher)
            end
            json[:result] = res
        end
        render :json => json
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