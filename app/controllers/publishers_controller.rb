class PublishersController < ApplicationController

    def index
        page = params[:page] || 1
        query = params[:query] || ''

        searcher = Publisher.search do
            fulltext query
            paginate(:page => page, :per_page => 15)

            order_by(:score, :desc)
            order_by(:name_sortable, :asc)
        end

        @results = Kaminari.paginate_array(
            searcher.results, total_count: searcher.hits.total_count).page(page).per(15)

        respond_to do |format|
            format.html { render 'refable/index' }
        end
    end

    def show
        @refable = Publisher.find(params[:id])

        respond_to do |format|
            format.html { render 'refable/show' }
        end
    end

    def new
        @refable = Publisher.new
    end

    def create
        @refable = Publisher.new(params[:publisher])

        respond_to do |format|
            if @refable.save
                format.html { redirect_to @refable, :notice => 'Publisher was successfully created.' }
                format.json { render :json => @refable, :status => :created, :location => @refable }
            else
                format.html { render :action => "new" }
                format.json { render :json => @refable.errors, :status => :unprocessable_entity }
            end
        end
    end

    def edit
        @refable = Publisher.find(params[:id])

        render 'refable/edit'
    end

    def update
        @refable = Publisher.find(params[:id])

        respond_to do |format|
            if @refable.update_attributes(params[:publisher])
                format.html { redirect_to publisher_path(@refable), :notice => 'Publisher was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render :action => "edit" }
                format.json { render :json => @refable.errors, :status => :unprocessable_entity }
            end
        end
    end
end