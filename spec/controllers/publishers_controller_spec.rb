require 'spec_helper'

describe PublishersController, type: :controller do

    describe "show" do
        it "returns the specified refable" do
            refable = FactoryGirl.create :publisher

            get :show, id: refable

            expect(assigns(:refable)).to eq(refable)
        end

        it "returns a sorted list of publisher's journals" do
            pub = FactoryGirl.create :publisher
            j1 = FactoryGirl.create(:journal, publisher: pub, name: "Zumblelumb")
            j2 = FactoryGirl.create(:journal, publisher: pub, name: "Bumbletumb")

            get :show, id: pub
            expect(assigns(:journals)).to eq([j2, j1])
        end

        it "returns a sorted list of publisher's aliases" do
            pub = FactoryGirl.create :publisher
            a1 = FactoryGirl.create(:entity_ref, refable: pub, refvalue: "Zoop")
            a2 = FactoryGirl.create(:entity_ref, refable: pub, refvalue: "Zaap")

            get :show, id: pub
            expect(assigns(:aliases)).to eq([a2, a1])
        end
    end

    describe "new" do
        it "renders the new view" do
            get :new

            expect(response).to render_template :new
        end

        it "assigns the refable variable" do
            get :new

            expect(assigns(:refable)).not_to be_nil
        end
    end

    describe "create" do
        it "creates a new publisher" do
            expect {
                post :create, publisher: FactoryGirl.attributes_for(:publisher)
            }.to change(Publisher, :count).by(1)
        end

        it "notifies user of successful publisher creation" do
            post :create, publisher: FactoryGirl.attributes_for(:publisher)
            expect(flash[:notice]).not_to be_nil
        end
    end

    describe "edit" do
        it "returns the specified refable" do
            refable = FactoryGirl.create :publisher

            get :edit, id: refable

            expect(assigns(:refable)).to eq(refable)
        end
    end

    describe "update" do
        before :each do
            @publisher = FactoryGirl.create :publisher
        end

        it "locates the requested publisher" do
            put :update, id: @publisher, publisher: FactoryGirl.attributes_for(
                :publisher)

            expect(assigns(:refable)).to eq(@publisher)
        end

        it "changes a publisher's attributes" do
            put :update, id: @publisher, publisher: FactoryGirl.attributes_for(
                :publisher, name: "Stumplenick")

            @publisher.reload

            expect(@publisher.name).to eq("Stumplenick")
        end
    end

    describe "destroy" do
        before :each do
            @pub = FactoryGirl.create :publisher
        end

        it "deletes the specified publisher" do
            expect {
                delete :destroy, id: @pub
            }.to change(Publisher, :count).by(-1)
        end

        it "redirects to publishers list" do
            delete :destroy, id: @pub
            expect(response).to redirect_to(publishers_url)
        end
    end
end