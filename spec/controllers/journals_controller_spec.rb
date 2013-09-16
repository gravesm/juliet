require 'spec_helper'

describe JournalsController do

    describe "show" do
        it "returns the specified journal" do
            journal = FactoryGirl.create :journal

            get :show, id: journal

            expect(assigns(:refable)).to eq(journal)
        end
    end

    describe "edit" do
        it "returns the specified journal" do
            journal = FactoryGirl.create :journal

            get :edit, id: journal

            expect(assigns(:refable)).to eq(journal)
        end
    end

    describe "update" do
        before :each do
            @journal = FactoryGirl.create :journal
        end

        it "locates the requested journal" do
            put :update, id: @journal

            expect(assigns(:refable)).to eq(@journal)
        end

        it "changes a journal's attributes" do
            put :update, id: @journal, journal: FactoryGirl.attributes_for(
                :journal, name: "Thimblesticks")

            @journal.reload

            expect(@journal.name).to eq("Thimblesticks")
        end
    end
end

