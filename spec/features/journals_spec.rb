
describe "Journals" do

    context "when searched" do

        it "returns matching items" do

            Journal.stub(:search) do
                j1 = FactoryGirl.create :journal, name: "Morlock"
                j2 = FactoryGirl.create :journal, name: "Tarzan"
                double :searcher, :results => [j1, j2]
            end

            visit journals_path

            fill_in "query", with: "Martian Overmind"
            click_button "Search"

            expect(page).to have_content("Morlock")
            expect(page).to have_content("Tarzan")
        end
    end



    describe "Edit" do

        it "updates journal attributes" do
            journal = FactoryGirl.create :journal, name: "Blorphimatic"

            visit edit_journal_path(journal)

            within "#edit_journal_#{journal.id}" do
                fill_in "journal_name", with: "Frobber"
            end
            click_button "Update Journal"
            expect(find("h1").text).to eq("Frobber")
        end

        it "deletes an existing alias", js: true do
            journal = FactoryGirl.create :journal, :with_alias

            visit edit_journal_path(journal)
            click_button "Delete alias"

            expect(page).to have_no_selector('.alias-input .uneditable-input')
        end

        it "adds and deletes an alias", js: true do
            journal = FactoryGirl.create :journal
            FactoryGirl.create :ref_type

            visit edit_journal_path(journal)
            click_link "Add a new alias"
            fill_in "add_alias", with: "Filbernip"
            click_button "Add Alias"

            expect(find(".alias-input .uneditable-input").text).to eq("Filbernip")

            click_button "Delete alias"
            expect(page).to have_no_selector('.alias-input .uneditable-input')
        end
    end
end
