class PoliciesController < ApplicationController
    before_filter :get_refable

    def new
        @policy = Policy.new
    end

    def create
        @policy = Policy.new(policy_params)
        @policy.policyable = @refable

        respond_to do |format|
            if @policy.save
                format.html { redirect_to @refable, :notice => 'Policy was successfully created.' }
                format.json {
                    render partial: "policy", locals: { policy: @policy },
                    status: :created
                }
            else
                format.html { render :action => "new" }
                format.json { render :json => @policy.errors, :status => :unprocessable_entity }
            end
        end
    end

    def edit
        @policy = Policy.find(params[:id])
    end

    def update
        @policy = Policy.find(params[:id])

        respond_to do |format|
            if @policy.update_attributes(policy_params)
                format.html { redirect_to @policy.policyable, :notice => 'Policy was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render :action => "edit" }
                format.json { render :json => @policy.errors, :status => :unprocessable_entity }
            end
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
