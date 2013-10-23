describe "Publishers" do

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
end
