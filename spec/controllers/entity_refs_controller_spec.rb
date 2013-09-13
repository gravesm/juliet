require 'spec_helper'

describe EntityRefsController do

    it "returns the journal" do
        journal = FactoryGirl.create :journal, :with_alias

        get :index, journal_id: journal

        expect(assigns(:refable)).to eq(journal)
    end

    it "creates new alias for a journal" do
        journal = FactoryGirl.create :journal
        FactoryGirl.create :ref_type

        e_ref = FactoryGirl.attributes_for(:entity_ref, refvalue: "Rimblenuff")

        post :create, journal_id: journal, entity_ref: e_ref

        expect(journal.entity_refs.count).to eq(1)
        expect(journal.entity_refs.first.refvalue).to eq("Rimblenuff")
    end

    it "deletes an alias for a journal" do
        journal = FactoryGirl.create :journal, :with_alias

        delete :destroy, journal_id: journal, id: journal.entity_refs.first

        expect(journal.entity_refs.count).to eq(0)
    end

end