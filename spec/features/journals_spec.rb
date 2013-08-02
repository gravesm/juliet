
describe "Journals" do

    describe "Edit" do

        it "updates journal attributes" do
            journal = FactoryGirl.create :journal, name: "Blorphimatic"

            visit edit_journal_path(journal)

            within "#edit_journal_#{journal.id}" do
                fill_in "journal_name", with: "Frobber"
            end
            click_button "Update Journal"
            expect(find_field("journal_name").value).to eq("Frobber")
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
