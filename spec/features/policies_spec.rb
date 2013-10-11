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

    describe "SHERPA lookup" do

        before :each do
            @uri = /http:\/\/www\.sherpa\.ac\.uk.*/
            @pub = FactoryGirl.create :publisher
            @pub_response = %q(
                <romeo>
                    <publishers>
                        <publisher>
                            <name>Wiggle</name>
                            <conditions>
                                <condition>you may deposit in
                                    &lt;a&gt;Wimplenuck&lt;/a&gt; after 6 months</condition>
                            </conditions>
                        </publisher>
                        <publisher><name>Wumple</name></publisher>
                    </publishers>
                </romeo>)
        end

        WebMock.disable_net_connect!(:allow_localhost => true)

        it "turns escaped elements into DOM nodes", js: true do
            stub_request(:any, @uri).to_return(
                body: @pub_response)

            visit new_polymorphic_path([@pub, :policy])

            expect(page).to have_selector(:xpath, "//a[text()='Wimplenuck']")
        end

        it "displays multiple publisher policies", js: true do
            stub_request(:any, @uri).to_return(
                body: @pub_response)

            visit new_polymorphic_path([@pub, :policy])

            expect(page).to have_content("Wiggle")
            expect(page).to have_content("Wumple")
        end

        it "makes followup requests for journals with no publisher", js: true do
            stub_request(:any, @uri).to_return(
                body: %q(
                    <romeo>
                        <journals>
                            <journal>
                                <jtitle>Fee</jtitle>
                                <romeopub>Fee</romeopub>
                                <zetocpub>Fee</zetocpub>
                            </journal>
                            <journal>
                                <jtitle>Fi</jtitle>
                                <romeopub>Fi</romeopub>
                                <zetocpub>Fi</zetocpub>
                            </journal>
                        </journals>
                    </romeo>), body: @pub_response)

            visit new_polymorphic_path([@pub, :policy])

            expect(page).to have_content("Wiggle")
        end

        it "displays a message when no policies are found", js: true do
            stub_request(:any, @uri)

            visit new_polymorphic_path([@pub, :policy])

            expect(page).to have_content("No matching policies found")
        end
    end
end