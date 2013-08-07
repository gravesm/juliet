describe SearchController do
    describe "index" do
        it "creates an array of journals for exact match" do
            journal = FactoryGirl.create :journal

            get :index, query: "Journal of Feline Whisker Weaving"

            expect(assigns(:journals)).to match_array([journal])
        end

        it "creates an array of journals for case insensitive match" do
            journal = FactoryGirl.create :journal

            get :index, query: "journal of feline whisker weaving"

            expect(assigns(:journals)).to match_array([journal])
        end

        it "does not do partial matching" do
            journal = FactoryGirl.create :journal

            get :index, query: "Feline"

            expect(assigns(:journals)).to be_empty
        end
    end
end