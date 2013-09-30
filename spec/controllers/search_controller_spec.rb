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
end