describe SearchController do
    describe "index" do
        it "creates an array of journals for exact match" do
            journal = FactoryGirl.create :journal

            get :index, query: "Journal of Feline Whisker Weaving"

            expect(assigns(:journal)).to eq(journal)
        end

        it "creates an array of journals for case insensitive match" do
            journal = FactoryGirl.create :journal

            get :index, query: "journal of feline whisker weaving"

            expect(assigns(:journal)).to eq(journal)
        end

        it "does not do partial matching" do
            journal = FactoryGirl.create :journal

            get :index, query: "Feline"

            expect(assigns(:journal)).to be_nil
        end
    end

    describe "search" do
        it "assigns result variable when successful journal match is found" do
            journal = FactoryGirl.create :journal, name: "Bubblemup"

            get :search, type: "journal", query: "Bubblemup"
            expect(assigns(:result)).to eq(journal)
        end

        it "assigns result variable when successful publisher match is found" do
            pub = FactoryGirl.create :publisher, name: "Fiddleraff"

            get :search, type: "publisher", query: "Fiddleraff"
            expect(assigns(:result)).to eq(pub)
        end
    end

    describe "API" do
        it "returns journal as json" do
            j = FactoryGirl.create :journal, :with_alias, name: "Lord Snugglepants"

            get :search, type: "journal", query: "Lord Snugglepants"
            body = JSON.parse(response.body)
            expect(body["result"]["name"]).to eq(j.name)
        end

        it "returns publisher as json" do
            p = FactoryGirl.create :publisher, name: "Captain Fuzzynugget, Esq."

            get :search, type: "publisher", query: "Captain Fuzzynugget, Esq."
            body = JSON.parse(response.body)
            expect(body["result"]["name"]).to eq(p.name)
        end
    end
end