describe "Policies" do

    describe "edit" do

        it "updates policy information" do
            @policy = FactoryGirl.create(:publisher).policy
            visit edit_policy_path(@policy)

            within "#edit_policy_#{ @policy.id }" do
                fill_in "policy_contact", with: "Lord Snuggleswiff"
                fill_in "policy_embargo", with: 1
                select "Sword", from: "policy_method_of_acquisition"
                fill_in "policy_note", with: "He will trample your bones!"
                uncheck "policy_opt_out_required"
                uncheck "policy_should_request"
                fill_in "policy_message", with: "Papers, please."
            end
            click_button "Update Policy"

            @policy.reload

            expect(@policy.contact).to eq("Lord Snuggleswiff")
            expect(@policy.embargo).to eq(1)
            expect(@policy.method_of_acquisition).to eq("SWORD")
            expect(@policy.note).to eq("He will trample your bones!")
            expect(@policy.opt_out_required).to eq(false)
            expect(@policy.should_request).to eq(false)
            expect(@policy.message).to eq("Papers, please.")
        end
    end
end