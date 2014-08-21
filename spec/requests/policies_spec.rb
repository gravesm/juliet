describe "Policy API lets API clients", type: :request do
    it "create a policy for a publisher" do
        pub = FactoryGirl.create :publisher, policy: nil
        policy = { contact: "Muffincup" }
        post "/publishers/#{pub.id}/policies", policy: policy, format: "json"
        expect(response.status).to eq(201)
    end

    it "create a policy for a journal" do
        j = FactoryGirl.create :journal, policy: nil
        policy = { contact: "Tinselwhup" }
        post "/journals/#{j.id}/policies", policy: policy, format: "json"
        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)["contact"]).to eq("Tinselwhup")
    end
end