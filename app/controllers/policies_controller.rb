class PoliciesController < ApplicationController
    before_filter :get_refable
    respond_to :html, :xml, :json

    def new
        @policy = Policy.new
        respond_with(@refable, @policy)
    end

    def create
        @policy = @refable.build_policy(policy_params)
        flash[:notice] = 'Policy was successfully created.' if @policy.save
        respond_with(@refable, @policy) do |format|
            format.html { redirect_to @refable }
        end
    end

    def edit
        @policy = Policy.find(params[:id])
        respond_with(@refable, @policy)
    end

    def update
        @policy = Policy.find(params[:id])
        if @policy.update_attributes(policy_params)
            flash[:notice] = "Policy was successfully updated."
        end
        respond_with(@refable, @policy) do |format|
            format.html { redirect_to @refable }
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

        def policy_params
            params.require(:policy).permit(:contact, :embargo, :note, :requirements,
                                           :method_of_acquisition, :opt_out_required,
                                           :should_request, :message)
        end
end
