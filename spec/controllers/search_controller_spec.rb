require 'spec_helper'

describe SearchController, type: :controller do
    describe "index" do
        it "creates an array of journals for exact match" do
            journal = FactoryGirl.create :journal

            get :index, query: "Journal of Feline Whisker Weaving"

            expect(assigns(:journal)).to eq(journal)
        end

        it "creates an array of journals for case insensitive match" do
            journal = FactoryGirl.create :journal

            get :index, query: "journal of feline whisker weaving"

            expect(assigns(:journal)).to eq(journal)
        end

        it "does not do partial matching" do
            journal = FactoryGirl.create :journal

            get :index, query: "Feline"

            expect(assigns(:journal)).to be_nil
        end
    end

    describe "search" do
        it "assigns refable variable when successful journal match is found" do
            journal = FactoryGirl.create :journal, name: "Bubblemup"

            get :search, type: "journal", query: "Bubblemup", format: :json
            expect(assigns(:refable)).to eq(journal)
        end

        it "assigns refable variable when successful publisher match is found" do
            pub = FactoryGirl.create :publisher, name: "Fiddleraff"

            get :search, type: "publisher", query: "Fiddleraff", format: :json
            expect(assigns(:refable)).to eq(pub)
        end
    end
end