describe "Journal API", type: :request do
    describe "lets API clients" do
        it "create journals" do
            pub = FactoryGirl.create :publisher
            j = { :name => "Grumblekinder" }
            post "/publishers/#{pub.id}/journals", journal: j, format: "json"
            expect(response.status).to eq(201)
            res = JSON.parse(response.body)
            expect(res["name"]).to eq("Grumblekinder")
            expect(res["href"]).to be
        end

        it "create aliases for journals" do
            j = FactoryGirl.create :journal
            FactoryGirl.create :ref_type
            eref = { :refvalue => "Frumbletuckus" }
            post "/journals/#{j.id}/entity_refs", entity_ref: eref, format: "json"
            expect(response.status).to eq(201)
            expect(JSON.parse(response.body)["aliases"]).to eq(["Frumbletuckus"])
        end

        it "retrieve a journal" do
            j = FactoryGirl.create :journal, :name => "Zimpflerinde"
            get "/journals/#{j.id}", format: "json"
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["name"]).to eq("Zimpflerinde")
        end

        it "retrieve a journal with href" do
            j = FactoryGirl.create :journal
            get "/journals/#{j.id}", format: "json"
            expect(JSON.parse(response.body)["href"]).to eq(
                "http://www.example.com/journals/#{j.id}")
        end

        it "delete journals" do
            j = FactoryGirl.create :journal
            delete "/journals/#{j.id}", format: "json"
            expect(response.status).to eq(204)
        end

        it "retrieve journal policy with journal" do
            j = FactoryGirl.create :journal
            get "/journals/#{j.id}", format: "json"
            expect(JSON.parse(response.body)["policy"]["contact"]).to eq(
                "Captain Figglesworth, Esq.")
        end

        it "retrieve publisher policy with journal" do
            j = FactoryGirl.create :journal, :policy => nil
            get "/journals/#{j.id}", format: "json"
            expect(JSON.parse(response.body)["policy"]["type"]).to eq("Publisher")
        end

        it "retrieve policy with href" do
            j = FactoryGirl.create :journal
            get "/journals/#{j.id}", format: "json"
            expect(JSON.parse(response.body)["policy"]["href"]).to eq(
                "http://www.example.com/journals/#{j.id}/policies/#{j.policy.id}")
        end

        it "retrieve a journal as XML" do
            j = FactoryGirl.create :journal, name: "Catmenistan"
            get "/journals/#{j.id}", format: "xml"
            res = Nokogiri::XML(response.body)
            expect(res.at_xpath("/journal/name").text).to eq("Catmenistan")
        end
    end
end