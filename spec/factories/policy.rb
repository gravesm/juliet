FactoryGirl.define do
    factory :policy do
        contact "Captain Figglesworth, Esq."
        embargo 6
        harvest_method "Author"
        harvestable true
        note "Captain Figglesworth, Esq. runs a top notch outfit. I like the cut of his jib."
        opt_out_required true
        should_request true
        message "Please enjoy this complimentary copy, courtesy Captain Figglesworth, Esq."
    end
end