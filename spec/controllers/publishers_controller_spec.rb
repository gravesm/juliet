require 'spec_helper'

describe PublishersController do

    describe "show" do
        it "returns the specified refable" do
            refable = FactoryGirl.create :publisher

            get :show, id: refable

            expect(assigns(:refable)).to eq(refable)
        end
    end

    describe "edit" do
        it "returns the specified refable" do
            refable = FactoryGirl.create :publisher

            get :edit, id: refable

            expect(assigns(:refable)).to eq(refable)
        end
    end

    describe "update" do
        before :each do
            @publisher = FactoryGirl.create :publisher
        end

        it "locates the requested publisher" do
            put :update, id: @publisher

            expect(assigns(:refable)).to eq(@publisher)
        end

        it "changes a publisher's attributes" do
            put :update, id: @publisher, publisher: FactoryGirl.attributes_for(
                :publisher, name: "Stumplenick")

            @publisher.reload

            expect(@publisher.name).to eq("Stumplenick")
        end
    end
end