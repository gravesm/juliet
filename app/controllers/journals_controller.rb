class JournalsController < ApplicationController
  include RefablesHelper
  # GET /journals
  # GET /journals.json
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

    respond_to do |format|
      format.html { render 'refable/index' }
      # format.json { render :json => @journals }
    end
  end

  # GET /journals/1
  # GET /journals/1.json
  def show
    @refable = Journal.find(params[:id])
    @aliases = @refable.entity_refs.order(:refvalue)
    @confirm = "This will permanently delete this journal, its policy and all its aliases. Are you sure you want to do this?"

    respond_to do |format|
      format.html { render 'refable/show' }
      format.json { render json: refable_to_json(@refable) }
      format.xml
    end
  end

  def new
    @publisher = Publisher.find(params[:id])
    @refable = Journal.new
    @refable.publisher = @publisher
  end

  def create
    @publisher = Publisher.find(params[:id])
    @refable = Journal.new(params[:journal])
    @refable.publisher = @publisher

    respond_to do |format|
      if @refable.save
        format.html { redirect_to @refable, :notice => 'Journal was successfully created.' }
        format.json { render json: refable_to_json(@refable), status: :created }
      else
        format.html { render :action => "new" }
        format.json { render :json => @refable.errors, :status => :unprocessable_entity }
      end
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

    respond_to do |format|
      if @refable.update_attributes(params[:journal])
        format.html { redirect_to journal_path(@refable), :notice => 'Journal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render "refable/edit" }
        format.json { render :json => @refable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /journals/1
  # DELETE /journals/1.json
  def destroy
    @refable = Journal.find(params[:id])
    @refable.destroy

    respond_to do |format|
      format.html { redirect_to publisher_path(@refable.publisher) }
      format.json { head :no_content }
    end
  end
end
