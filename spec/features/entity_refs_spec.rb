require 'spec_helper'

describe "EntityRefs", type: :feature do

    it "lists the aliases for a journal" do
        journal = FactoryGirl.create :journal
        e_ref = FactoryGirl.create(:entity_ref, refable: journal, refvalue: "Fogglerip")

        visit journal_entity_refs_url(journal)

        expect(page).to have_content("Fogglerip")
    end

    it "adds a new alias for a journal" do
        journal = FactoryGirl.create :journal
        FactoryGirl.create :ref_type

        visit journal_entity_refs_url(journal)
        fill_in("Add a new alias:", with: "Macklethorph")
        click_button("Add")

        expect(page).to have_content("Alias Macklethorph added")
    end

    it "displays an error when adding an existing alias" do
        journal = FactoryGirl.create :journal
        e_ref = FactoryGirl.create(:entity_ref, refable: journal, refvalue: "Aarnifumple")

        visit journal_entity_refs_url(journal)
        fill_in("Add a new alias:", with: "Aarnifumple")
        click_button("Add")

        expect(page).to have_selector(".alert-danger")
    end

    it "deletes an existing alias for a journal" do
        journal = FactoryGirl.create :journal
        e_ref = FactoryGirl.create(:entity_ref, refable: journal, refvalue: "Cambertumph")

        visit journal_entity_refs_url(journal)
        click_link("Delete")

        expect(page).to have_content("Alias Cambertumph deleted")
        expect(page).to have_no_selector("id_entity_ref_#{ e_ref.id }")
    end
end