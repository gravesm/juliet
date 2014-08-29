class JournalsController < ApplicationController
  respond_to :html, :json, :xml

  def index

    page = params[:page] || 1
    query = params[:query] || ''

    searcher = Journal.search do
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

    respond_with(@refable) do |format|
      format.html { render 'refable/index' }
    end
  end

  # GET /journals/1
  # GET /journals/1.json
  def show
    @refable = Journal.find(params[:id])
    @aliases = @refable.entity_refs.order(:refvalue)
    @confirm = "This will permanently delete this journal, its policy and all its aliases. Are you sure you want to do this?"

    respond_with(@refable) do |format|
      format.html { render 'refable/show' }
    end
  end

  def new
    @publisher = Publisher.find(params[:id])
    @refable = @publisher.journals.build
    respond_with(@refable)
  end

  def create
    @publisher = Publisher.find(params[:id])
    @refable = @publisher.journals.build(journal_params)
    flash[:notice] = "Journal was successfully created." if @refable.save
    respond_with(@refable) do |format|
      format.json { render status: :created } # Why, Rails?
    end
  end

  # GET /journals/1/edit
  def edit
    @refable = Journal.find(params[:id])

    render 'refable/edit'
  end

  # PUT /journals/1
  # PUT /journals/1.json
  def update
    @refable = Journal.find(params[:id])
    if @refable.update_attributes(journal_params)
      flash[:notice] = "Journal was successfully updated."
    end
    respond_with(@refable)
  end

  # DELETE /journals/1
  # DELETE /journals/1.json
  def destroy
    @refable = Journal.find(params[:id])
    @refable.destroy
    flash[:notice] = "Journal was successfully deleted."
    respond_with(@refable.publisher)
  end

  private
    def journal_params
      params.require(:journal).permit(:note, :name, :publisher_id)
    end
end
