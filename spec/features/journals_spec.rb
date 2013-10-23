
describe "Journals" do

    before :each do
        stub_request(:any, /http:\/\/www\.sherpa\.ac\.uk.*/)
    end

    describe "create" do

        it "creates a new journal" do

            @pub = FactoryGirl.create :publisher

            visit "/journals/new?publisher=#{@pub.id}"

            fill_in "Canonical Name", with: "Gumblenuffins"
            click_button "Create Journal"

            expect(find("h1").text).to eq("Gumblenuffins")
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
    end

    describe "Delete" do
        before :each do
            @journal = FactoryGirl.create :journal
        end

        it "deletes a journal" do
            visit journal_path(@journal)

            expect {
                click_link "Delete Journal"
            }.to change(Journal, :count).by(-1)

            expect(find("h1").text).to eq("Cat Arts")
        end
    end
end
