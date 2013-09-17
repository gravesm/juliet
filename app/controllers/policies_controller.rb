class PoliciesController < ApplicationController

    def edit
        @policy = Policy.find(params[:id])
    end

    def update
        @policy = Policy.find(params[:id])

        respond_to do |format|
            if @policy.update_attributes(params[:policy])
                format.html { redirect_to @policy.policyable, :notice => 'Policy was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render :action => "edit" }
                format.json { render :json => @policy.errors, :status => :unprocessable_entity }
            end
        end
    end
end
