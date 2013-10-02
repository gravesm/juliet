FactoryGirl.define do
    factory :publisher do
        name "Cat Arts"
        policy

        trait :with_alias do
            after(:create) do |p|
                create :entity_ref, refable: p
            end
        end
    end
end
