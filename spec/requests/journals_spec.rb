describe "Journal API" do
    describe "lets API clients" do
        it "create journals" do
            pub = FactoryGirl.create :publisher
            j = { :name => "Grumblekinder" }
            post "/publishers/#{pub.id}/journals", journal: j, format: "json"
            expect(response.status).to eq(201)
            expect(JSON.parse(response.body)["name"]).to eq("Grumblekinder")
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

        it "delete journals" do
            j = FactoryGirl.create :journal
            delete "/journals/#{j.id}", format: "json"
            expect(response.status).to eq(204)
        end
    end
end