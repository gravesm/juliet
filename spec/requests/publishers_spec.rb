describe "Publisher API" do
    describe "lets API clients" do
        it "create publishers" do
            pub = { :name => "Figglewallup" }
            post "/publishers", publisher: pub, format: "json"
            expect(response.status).to eq(201)
            res = JSON.parse(response.body)
            expect(res["name"]).to eq("Figglewallup")
            expect(res["href"]).to be
        end

        it "create aliases for publishers" do
            pub = FactoryGirl.create :publisher
            FactoryGirl.create :ref_type
            eref = { :refvalue => "Gimblecrumb" }
            post "/publishers/#{pub.id}/entity_refs", entity_ref: eref, format: "json"
            expect(response.status).to eq(201)
            expect(JSON.parse(response.body)["aliases"]).to eq(["Gimblecrumb"])
        end

        it "retrieve a publisher" do
            pub = FactoryGirl.create :publisher, :name => "Bramblenip"
            get "/publishers/#{pub.id}", format: "json"
            expect(response.status).to eq(200)
            res = JSON.parse(response.body)
            expect(res["name"]).to eq("Bramblenip")
            expect(res["href"]).to eq("http://www.example.com/publishers/#{pub.id}")
        end

        it "delete publishers" do
            pub = FactoryGirl.create :publisher
            delete "/publishers/#{pub.id}", format: "json"
            expect(response.status).to eq(204)
        end

        it "retrieve a policy with publisher" do
            pub = FactoryGirl.create :publisher
            get "/publishers/#{pub.id}", format: "json"
            expect(JSON.parse(response.body)["policy"]["contact"]).to eq(
                "Captain Figglesworth, Esq.")
        end

        it "retrieve a policy with href" do
            pub = FactoryGirl.create :publisher
            get "/publishers/#{pub.id}", format: "json"
            expect(JSON.parse(response.body)["policy"]["href"]).to eq(
                "http://www.example.com/publishers/#{pub.id}/policies/#{pub.policy.id}")
        end
    end
end