describe "Search API" do
    describe "using JSON" do
        it "returns journal" do
            j = FactoryGirl.create :journal, :with_alias, name: "Lord Snugglepants"
            get "/search/journal", query: "Lord Snugglepants", format: :json
            body = JSON.parse(response.body)
            expect(body["result"]["name"]).to eq(j.name)
        end

        it "returns publisher" do
            p = FactoryGirl.create :publisher, name: "Captain Fuzzynugget, Esq."
            get "/search/publisher", query: "Captain Fuzzynugget, Esq.", format: :json
            body = JSON.parse(response.body)
            expect(body["result"]["name"]).to eq(p.name)
        end

        it "returns no result when no match is found" do
            j = FactoryGirl.create :journal
            get "/search/journal", query: "Frimblenick", format: :json
            body = JSON.parse(response.body)
            expect(body["result"]).to be_nil
        end
    end
    describe "using XML" do
        it "returns a journal" do
            j = FactoryGirl.create :journal, :with_alias, name: "Mister Pumpkins"
            get "/search/journal", query: "Mister Pumpkins", format: :xml
            res = Nokogiri::XML(response.body)
            expect(res.at_xpath("/response/result/journal/name").text).to eq("Mister Pumpkins")
        end

        it "returns a publisher" do
            p = FactoryGirl.create :publisher, :with_alias, name: "Max von Catsen, III"
            get "/search/publisher", query: "Max von Catsen, III", format: :xml
            res = Nokogiri::XML(response.body)
            expect(res.at_xpath("/response/result/publisher/name").text).to eq("Max von Catsen, III")
        end

        it "returns no result when no match is found" do
            p = FactoryGirl.create :publisher
            get "/search/publisher", query: "Wambleramble", format: :xml
            res = Nokogiri::XML(response.body)
            expect(res.at_xpath("/response/result")).to be_nil
        end
    end
end