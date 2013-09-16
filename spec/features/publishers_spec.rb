describe "Publishers" do

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
end
