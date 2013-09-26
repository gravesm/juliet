class EntityRefsController < ApplicationController

  before_filter :get_refable

  def index
  end

  def create
    @entity_ref = @refable.entity_refs.new(params[:entity_ref])
    @entity_ref.ref_type = RefType.where("type_name = ?", "Alias").first

    respond_to do |format|
      if @entity_ref.save
        Sunspot.index @refable
        format.html {
          redirect_to url_for([@refable, :entity_refs]),
          notice: "Alias #{ @entity_ref.refvalue } added."
        }
        format.json { render json: @entity_ref, status: :created, location: @entity_ref }
      else
        format.html {
          redirect_to url_for([@refable, :entity_refs]),
          alert: @entity_ref.errors.full_messages.to_sentence
        }
        format.json { render json: @entity_ref.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entity_ref = EntityRef.find(params[:id])
    @entity_ref.destroy
    Sunspot.index @refable

    respond_to do |format|
      format.html {
        redirect_to url_for([@refable, :entity_refs]),
        notice: "Alias #{ @entity_ref.refvalue } deleted."
      }
      format.json { head :ok }
    end
  end

  private
    def get_refable
      if params.has_key?(:journal_id)
        @refable = Journal.find(params[:journal_id])
      else
        @refable = Publisher.find(params[:publisher_id])
      end
    end
end