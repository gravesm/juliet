require 'spec_helper'

describe JournalsController, type: :controller do

    describe "index", search: true do
        it "assigns the results variable" do
            j = FactoryGirl.create :journal, name: "Muffincup"
            Sunspot.commit
            get :index, query: "Muffin"
            expect(assigns(:results)).to eq([j])
        end
    end

    describe "show" do
        it "returns the specified journal" do
            journal = FactoryGirl.create :journal

            get :show, id: journal

            expect(assigns(:refable)).to eq(journal)
        end

        it "returns a sorted list of journal's aliases" do
            j = FactoryGirl.create :journal
            a1 = FactoryGirl.create(:entity_ref, refable: j, refvalue: "Gimbleberry")
            a2 = FactoryGirl.create(:entity_ref, refable: j, refvalue: "Fringleton")

            get :show, id: j
            expect(assigns(:aliases)).to eq([a2, a1])
        end
    end

    describe "new" do

        before :each do
            @pub = FactoryGirl.create :publisher
        end

        it "renders the new view" do
            get :new, id: @pub

            expect(response).to render_template :new
        end

        it "assigns the publisher and refable variables" do
            get :new, id: @pub

            expect(assigns(:publisher)).to eq(@pub)
            expect(assigns(:refable)).not_to be_nil
        end

        it "creates a new journal object" do
            get :new, id: @pub
            expect(assigns(:refable)).to be_a_new(Journal)
        end
    end

    describe "create" do

        before :each do
            @pub = FactoryGirl.create :publisher
            @journal = FactoryGirl.attributes_for(:journal).merge({ publisher_id: @pub })
        end

        it "returns created status when using json" do
            post :create, journal: @journal, id: @pub, format: :json
            expect(response).to have_http_status(:created)
        end

        it "creates a new journal" do
            journal = FactoryGirl.attributes_for(:journal)

            expect {
                post :create, journal: @journal, id: @pub
            }.to change(Journal, :count).by(1)
        end

        it "notifies user of successful journal creation" do
            post :create, journal: @journal, id: @pub
            expect(flash[:notice]).not_to be_nil
        end
    end

    describe "edit" do
        it "returns the specified journal" do
            journal = FactoryGirl.create :journal

            get :edit, id: journal

            expect(assigns(:refable)).to eq(journal)
        end
    end

    describe "update" do
        before :each do
            @journal = FactoryGirl.create :journal
        end

        it "locates the requested journal" do
            put :update, id: @journal, journal: FactoryGirl.attributes_for(:journal)

            expect(assigns(:refable)).to eq(@journal)
        end

        it "changes a journal's canonical name" do
            put :update, id: @journal, journal: FactoryGirl.attributes_for(
                :journal, name: "Thimblesticks")

            @journal.reload

            expect(@journal.name).to eq("Thimblesticks")
        end

        it "changes a journal's publisher" do
            pub = FactoryGirl.create :publisher, name: "Hambow"
            put :update, id: @journal, journal: { publisher_id: pub.id }
            @journal.reload

            expect(@journal.publisher_id).to eq(pub.id)
        end
    end

    describe "destroy" do
        before :each do
            @journal = FactoryGirl.create :journal
        end

        it "deletes the specified journal" do
            expect {
                delete :destroy, id: @journal
            }.to change(Journal, :count).by(-1)
        end

        it "redirects to deleted journal's publisher" do
            delete :destroy, id: @journal
            expect(response).to redirect_to(publisher_path(@journal.publisher))
        end
    end

end

