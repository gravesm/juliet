describe "Policies" do

    describe "edit" do

        it "updates policy information" do
            publisher = FactoryGirl.create(:publisher)
            visit edit_polymorphic_path([publisher, publisher.policy])

            fill_in "policy_contact", with: "Lord Snuggleswiff"
            fill_in "policy_embargo", with: 1
            select "Sword", from: "policy_method_of_acquisition"
            fill_in "policy_note", with: "He will trample your bones!"
            uncheck "policy_opt_out_required"
            uncheck "policy_should_request"
            fill_in "policy_message", with: "Papers, please."

            click_button "Update Policy"

            publisher.reload

            expect(publisher.policy.contact).to eq("Lord Snuggleswiff")
            expect(publisher.policy.embargo).to eq(1)
            expect(publisher.policy.method_of_acquisition).to eq("SWORD")
            expect(publisher.policy.note).to eq("He will trample your bones!")
            expect(publisher.policy.opt_out_required).to eq(false)
            expect(publisher.policy.should_request).to eq(false)
            expect(publisher.policy.message).to eq("Papers, please.")
        end
    end

    describe "create" do

        before :each do
            @pub = FactoryGirl.create :publisher
        end

        it "adds a new policy" do
            visit new_polymorphic_path([@pub, :policy])

            click_button "Create Policy"

            expect(page).to have_content("Publisher Policy")
        end
    end
end