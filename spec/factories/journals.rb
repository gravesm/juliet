FactoryGirl.define do
    factory :journal, class: "Journal" do
        name "Journal of Feline Whisker Weaving"
        publisher

        trait :with_alias do
            after(:create) do |j|
                create :entity_ref, refable: j
            end
        end
    end
end
