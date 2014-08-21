describe "Publishers", type: :feature do

    before :each do
        stub_request(:any, /http:\/\/www\.sherpa\.ac\.uk.*/)
    end

    describe "create" do

        it "creates a new publisher" do

            visit new_publisher_path

            fill_in "Canonical Name", with: "Sassifrassypants"
            click_button "Create Publisher"

            expect(find("h1").text).to eq("Sassifrassypants")
        end
    end

    describe "Edit" do

        it "updates publisher attributes" do
            publisher = FactoryGirl.create :publisher, name: "Flugruffle"

            visit edit_publisher_path(publisher)

            within "#edit_publisher_#{publisher.id}" do
                fill_in "publisher_name", with: "Grumfiffle"
            end
            click_button "Update Publisher"
            expect(find("h1").text).to eq("Grumfiffle")
        end
    end

    describe "Delete" do
        before :each do
            @pub = FactoryGirl.create :publisher
        end

        it "deletes a publisher" do
            visit publisher_path(@pub)

            expect {
                click_link "Delete Publisher"
            }.to change(Publisher, :count).by(-1)

            expect(find("h1").text).to eq("Publishers")
        end
    end

    describe "show" do

        it "lists the journals in alphabetical order" do
            pub = FactoryGirl.create :publisher
            FactoryGirl.create(:journal, publisher: pub, name: "Frimble")
            FactoryGirl.create(:journal, publisher: pub, name: "Brumble")

            visit publisher_path(pub)

            within(:xpath, "//div[./div/h3[text() = 'Journals']]") do
                expect(all('li')[0].text).to eq("Brumble")
                expect(all('li')[1].text).to eq("Frimble")
            end
        end

        it "lists the aliases in alphabetical order" do
            pub = FactoryGirl.create :publisher
            a1 = FactoryGirl.create(:entity_ref, refable: pub, refvalue: "Mumbleruckus")
            a2 = FactoryGirl.create(:entity_ref, refable: pub, refvalue: "Dimblethump")

            visit publisher_path(pub)

            within(:xpath, "//div[./div/h3[text() = 'Aliases']]") do
                expect(all('li')[0].text).to eq("Dimblethump")
                expect(all('li')[1].text).to eq("Mumbleruckus")
            end
        end
    end
end
