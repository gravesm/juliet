require 'spec_helper'

describe PoliciesController do

    describe "create" do

        before :each do
            @pub = FactoryGirl.create :publisher
        end

        it "assigns policyable object for policy creation" do
            post :create, publisher_id: @pub

            expect(assigns(:policy).policyable).to eq(@pub)
        end

        it "creates a new policy object" do
            expect {
                post :create, publisher_id: @pub
            }.to change(Policy, :count).by(1)
        end

        it "notifies user of successful policy creation" do
            post :create, publisher_id: @pub
            expect(flash[:notice]).not_to be_nil
        end
    end


    it "returns a policy for editing" do
        publisher = FactoryGirl.create :publisher

        get :edit, publisher_id: publisher, id: publisher.policy

        expect(assigns(:policy)).to eq(publisher.policy)
    end

    it "updates a policy" do
        publisher = FactoryGirl.create :publisher

        put :update, publisher_id: publisher, id: publisher.policy,
            policy: FactoryGirl.attributes_for(:policy, contact: "General von Snuggles")

        publisher.reload

        expect(publisher.policy.contact).to eq("General von Snuggles")
    end
end
