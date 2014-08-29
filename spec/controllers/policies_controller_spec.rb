require 'spec_helper'

describe PoliciesController, type: :controller do
    before :each do
        @publisher = Publisher.create(name: "Whupwhup")
    end

    describe "#new" do
        it "assigns refable object" do
            get :new, publisher_id: @publisher
            expect(assigns(:refable)).to eq(@publisher)
        end

        it "creates a new policy object" do
            get :new, publisher_id: @publisher
            expect(assigns(:policy)).to be_a_new(Policy)
        end
    end

    describe "#create" do
        it "returns created status on success when using json" do
            post :create, publisher_id: @publisher, policy: { contact: "Tootsie" },
                format: :json
            expect(response).to have_http_status(:created)
        end

        it "redirects to refable on success when using html" do
            post :create, publisher_id: @publisher, policy: { contact: "Tootsie" }
            expect(response).to redirect_to(@publisher)
        end

        it "assigns policyable object for policy creation" do
            post :create, publisher_id: @publisher, policy: FactoryGirl.attributes_for(:policy)

            expect(assigns(:policy).policyable).to eq(@publisher)
        end

        it "creates a new policy object" do
            expect {
                post :create, publisher_id: @publisher, policy: FactoryGirl.attributes_for(:policy)
            }.to change(Policy, :count).by(1)
        end

        it "notifies user of successful policy creation" do
            post :create, publisher_id: @publisher, policy: FactoryGirl.attributes_for(:policy)
            expect(flash[:notice]).to eq("Policy was successfully created.")
        end
    end

    describe '#edit' do
        it "assigns policy" do
            @publisher.create_policy(contact: "Tootsie")
            get :edit, publisher_id: @publisher, id: @publisher.policy
            expect(assigns(:policy)).to eq(@publisher.policy)
        end
    end

    describe '#update' do
        before :each do
            @publisher.create_policy(contact: "Tootsie")
        end

        it "updates a policy" do
            put :update, publisher_id: @publisher, id: @publisher.policy,
                policy: FactoryGirl.attributes_for(:policy, contact: "General von Snuggles")
            @publisher.reload
            expect(@publisher.policy.contact).to eq("General von Snuggles")
        end

        it "redirects to refable on success when using html" do
            put :update, publisher_id: @publisher, id: @publisher.policy,
                policy: { contact: "General von Snuggles" }
            expect(response).to redirect_to(@publisher)
        end

        it "responds with 204 when using json" do
            put :update, publisher_id: @publisher, id: @publisher.policy,
                policy: { contact: "General von Snuggles" }, format: :json
            expect(response).to have_http_status(204)
        end

        it "notifies user policy was updated" do
            put :update, publisher_id: @publisher, id: @publisher.policy,
                policy: { contact: "General von Snuggles" }
            expect(flash[:notice]).to eq("Policy was successfully updated.")
        end
    end
end
