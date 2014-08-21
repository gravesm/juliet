class PublishersController < ApplicationController
    include RefablesHelper
    def index
        page = params[:page] || 1
        query = params[:query] || ''

        searcher = Publisher.search do
            fulltext query
            paginate(:page => page, :per_page => 15)

            order_by(:score, :desc)
            order_by(:name_sortable, :asc)
            adjust_solr_params do |params|
                params[:qs] = 40
            end
        end

        @results = Kaminari.paginate_array(
            searcher.results, total_count: searcher.hits.total_count).page(page).per(15)

        respond_to do |format|
            format.html { render 'refable/index' }
            format.json { render json: @results }
        end
    end

    def show
        @refable = Publisher.find(params[:id])
        @journals = @refable.journals.order(:name)
        @aliases = @refable.entity_refs.order(:refvalue)
        @confirm = "This will permanently delete this publisher, its policy and all its journals and aliases. Are you sure you want to do this?"

        respond_to do |format|
            format.html { render 'refable/show' }
            format.json { render json: refable_to_json(@refable) }
            format.xml
        end
    end

    def new
        @refable = Publisher.new
    end

    def create
        @refable = Publisher.new(publisher_params)

        respond_to do |format|
            if @refable.save
                format.html { redirect_to @refable, :notice => 'Publisher was successfully created.' }
                format.json { render json: refable_to_json(@refable), status: :created }
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
            if @refable.update_attributes(publisher_params)
                format.html { redirect_to publisher_path(@refable), :notice => 'Publisher was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render "refable/edit" }
                format.json { render :json => @refable.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        @refable = Publisher.find(params[:id])
        @refable.destroy

        respond_to do |format|
            format.html { redirect_to publishers_url }
            format.json { head :no_content }
        end
    end

    private
        def publisher_params
            params.require(:publisher).permit(:note, :name)
        end
end