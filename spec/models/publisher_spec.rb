describe Publisher do

    it "must have a canonical name" do
        expect(FactoryGirl.build :publisher, name: nil).to have(1).error_on(:name)
    end

    it "must have a unique canonical name" do
        FactoryGirl.create :publisher
        expect(FactoryGirl.build :publisher).to have(1).error_on(:name)
    end

    it "has an alias" do
        p = FactoryGirl.create :publisher, :with_alias
        expect(p.entity_refs.first.refvalue).to eq("J of FWW")
    end

    it "returns a publisher by name" do
        p = FactoryGirl.create :publisher, name: "Jimblethorne"
        expect(Publisher.by_name("jimblethorne").first).to eq(p)
    end

    it "has a policy" do
        p = FactoryGirl.create :publisher
        expect(p.policy.contact).to eq("Captain Figglesworth, Esq.")
    end
end