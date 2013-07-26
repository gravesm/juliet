require 'spec_helper'

describe EntityRef do
    it "must have a refable" do
        expect(FactoryGirl.build :entity_ref).to have(1).error_on(:refable)
    end

    it "must have a reftype" do
        expect(FactoryGirl.build :entity_ref, ref_type: nil)
            .to have(1).error_on(:ref_type)
    end

    it "must have a refable type" do
        expect(FactoryGirl.build :entity_ref, refable_type: nil)
            .to have(1).error_on(:refable_type)
    end

    it "must have a ref value" do
        expect(FactoryGirl.build :entity_ref, refvalue: nil)
            .to have(1).error_on(:refvalue)
    end

    it "must have a unique ref value" do
        j = FactoryGirl.create(:journal)
        FactoryGirl.create(:entity_ref, refable: j)
        expect(FactoryGirl.build :entity_ref, refable: j)
            .to have(1).error_on(:refvalue)
    end
end