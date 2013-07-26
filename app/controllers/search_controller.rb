class SearchController < ApplicationController
    def index
        if params[:query]
            @journals = Journal.by_name(params[:query]).group('journals.id')
        end
    end
end