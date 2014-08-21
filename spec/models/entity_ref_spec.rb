require 'spec_helper'

describe EntityRef, type: :model do
    it "must have a refable" do
        eref = FactoryGirl.build :entity_ref
        expect(eref.valid?).to be_falsey
        expect(eref.errors[:refable].size).to eq(1)
    end

    it "must have a reftype" do
        eref = FactoryGirl.build :entity_ref, ref_type: nil
        expect(eref.valid?).to be_falsey
        expect(eref.errors[:ref_type].size).to eq(1)
    end

    it "must have a refable type" do
        eref = FactoryGirl.build :entity_ref, refable_type: nil
        expect(eref.valid?).to be_falsey
        expect(eref.errors[:refable_type].size).to eq(1)
    end

    it "must have a ref value" do
        eref = FactoryGirl.build :entity_ref, refvalue: nil
        expect(eref.valid?).to be_falsey
        expect(eref.errors[:refvalue].size).to eq(1)
    end

    it "must have a unique ref value" do
        j = FactoryGirl.create :journal, :with_alias

        eref = FactoryGirl.build :entity_ref, refable: j
        expect(eref.valid?).to be_falsey
        expect(eref.errors[:refvalue].size).to eq(1)

        eref = FactoryGirl.build :entity_ref, refable: j, refvalue: j.name
        expect(eref.valid?).to be_falsey
        expect(eref.errors[:refvalue].size).to eq(1)
    end
end