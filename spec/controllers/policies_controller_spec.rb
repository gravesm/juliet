require 'spec_helper'

describe PoliciesController do

    it "returns a policy for editing" do
        policy = FactoryGirl.create :policy

        get :edit, id: policy

        expect(assigns(:policy)).to eq(policy)
    end

    it "updates a policy" do
        policy = FactoryGirl.create(:publisher).policy

        put :update, id: policy, policy: FactoryGirl.attributes_for(:policy,
            contact: "General von Snuggles")

        policy.reload

        expect(policy.contact).to eq("General von Snuggles")
    end
end
