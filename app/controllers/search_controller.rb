class SearchController < ApplicationController
    def index
        if params[:query]
            @journal = Journal.by_name(params[:query]).group('journals.id').first
        end
    end
end