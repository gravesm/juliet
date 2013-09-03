describe Policy do

    it "should not require a method of acquisition" do
        expect(FactoryGirl.build :policy, method_of_acquisition: nil).to have(0).
            error_on(:method_of_acquisition)
    end

    it "must use method of acquisition from the enumerated list, if present" do
        expect(FactoryGirl.build :policy,
            method_of_acquisition: "TELEPATHY").to have(1).error_on(:method_of_acquisition)
    end
end