class EntityRefsController < ApplicationController

  def create
    if params.has_key?(:journal_id)
      @refable = Journal.find(params[:journal_id])
    else
      @refable = Publisher.find(params[:publisher_id])
    end

    @entity_ref = @refable.entity_refs.new(params[:entity_ref])
    @entity_ref.ref_type = RefType.where("type_name = ?", "Alias").first
    if @entity_ref.save
        @entity_ref["url"] = url_for([@refable, @entity_ref])
        render :json => @entity_ref
    else
        render :json => @entity_ref.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @entity_ref = EntityRef.find(params[:id])
    @entity_ref.destroy

    render text: @entity_ref.refvalue
  end
end