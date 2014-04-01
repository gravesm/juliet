describe Journal do
    it "must have a canonical name" do
        expect(FactoryGirl.build :journal, name: nil).to have(1).error_on(:name)
    end

    it "must have a unique canonical name" do
        FactoryGirl.create :journal
        pub = FactoryGirl.create :publisher, name: "Fobblewhip"
        expect(FactoryGirl.build :journal, publisher: pub).to have(1).error_on(:name)
    end

    it "has an alias" do
        j = FactoryGirl.create :journal, :with_alias
        expect(j.entity_refs.first.refvalue).to eq("J of FWW")
    end

    it "has a publisher" do
        j = FactoryGirl.create :journal
        expect(j.publisher.name).to eq("Cat Arts")
    end

    it "must have a publisher" do
        expect(FactoryGirl.build :journal, publisher: nil).to have(1).error_on(:publisher)
    end

    it "returns a journal by name" do
        j = FactoryGirl.create :journal, name: "Scratching Post Digest"
        expect(Journal.by_name("scratching post digest").first).to eq(j)
    end

    it "has a policy" do
        j = FactoryGirl.create :journal
        expect(j.policy.contact).to eq("Captain Figglesworth, Esq.")
    end

    it "deletes policy when journal is deleted" do
        j = FactoryGirl.create :journal
        expect { j.destroy }.to change(Policy, :count).by(-1)
    end

    it "deletes aliases when journal is deleted" do
        j = FactoryGirl.create :journal, :with_alias
        expect { j.destroy }.to change(EntityRef, :count).by(-1)
    end
end
