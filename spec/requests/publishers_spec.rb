describe "Publisher API" do
    describe "lets API clients" do
        it "create publishers" do
            pub = { :name => "Figglewallup" }
            post "/publishers", publisher: pub, format: "json"
            expect(response.status).to eq(201)
            expect(JSON.parse(response.body)["name"]).to eq("Figglewallup")
        end

        it "create aliases for publishers" do
            pub = FactoryGirl.create :publisher
            FactoryGirl.create :ref_type
            eref = { :refvalue => "Gimblecrumb" }
            post "/publishers/#{pub.id}/entity_refs", entity_ref: eref, format: "json"
            expect(response.status).to eq(201)
            expect(JSON.parse(response.body)["aliases"]).to eq(["Gimblecrumb"])
        end

        it "retrive a publisher" do
            pub = FactoryGirl.create :publisher, :name => "Bramblenip"
            get "/publishers/#{pub.id}", format: "json"
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["name"]).to eq("Bramblenip")
        end

        it "delete publishers" do
            pub = FactoryGirl.create :publisher
            delete "/publishers/#{pub.id}", format: "json"
            expect(response.status).to eq(204)
        end
    end
end