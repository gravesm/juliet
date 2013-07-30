class EntityRefsController < ApplicationController

  def create
    @journal = Journal.find(params[:journal_id])
    @entity_ref = @journal.entity_refs.new(params[:entity_ref])
    @entity_ref.ref_type = RefType.where("type_name = ?", "Alias").first
    if @entity_ref.save
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