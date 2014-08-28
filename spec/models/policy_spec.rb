require 'spec_helper'

describe Policy, type: :model do

    it "should not require a method of acquisition" do
        p = FactoryGirl.build :policy, method_of_acquisition: nil
        expect(p.valid?).to be_truthy
        expect(p.errors[:method_of_acquisition].size).to eq(0)
    end

    it "must use method of acquisition from the enumerated list, if present" do
        p = FactoryGirl.build :policy, method_of_acquisition: "TELEPATHY"
        expect(p.valid?).to be_falsey
        expect(p.errors[:method_of_acquisition].size).to eq(1)
    end
end