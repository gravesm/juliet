require 'spec_helper'

describe "Search", type: :feature do
    it "displays policy for journal with policy" do
        j = FactoryGirl.create :journal, name: "Binglewump"

        visit root_path


        fill_in "query", with: "Binglewump"
        click_button "Search"

        expect(find(".policy-box")).to have_content("Captain Figglesworth, Esq.")
    end

    it "displays policy for publisher when journal has no policy" do
        j = FactoryGirl.create :journal, policy: nil, name: "Bojangles"

        visit root_path

        fill_in "query", with: "Bojangles"
        click_button "Search"

        expect(find(".policy-box")).to have_content("Captain Figglesworth, Esq.")
    end

    it "displays notice about policy being a publisher policy" do
        j = FactoryGirl.create :journal, policy: nil, name: "Zupercraften"

        visit root_path

        fill_in "query", with: "Zupercraften"
        click_button "Search"

        expect(find(".alert")).to have_content("No journal policy")
    end
end
