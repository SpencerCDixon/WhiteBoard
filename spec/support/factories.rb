FactoryGirl.define do
  factory :user do
    provider "google_oauth2"
    sequence(:uid) { |n| n.to_s }
    sequence(:email) { |n| "spencerdixon#{n}@gmail.com" }
    sequence(:name) { |n|  "Spencer Dixon #{n}" }
    sequence(:first_name) { |n|  "Spencer #{n}" }
    sequence(:last_name) { |n|  "Dixon #{n}" }
    image "https://lh6.googleusercontent.com/-AskbC7sGK7A/AAAAAAAAAAI/AAAAAAAAADA/nTDC13Uvcoc/photo.jpg?sz=50"
  end

  factory :family do
    sequence(:name) { |n| "Wadsworth Family #{n}" }
  end

  factory :family_membership do
    family
    user
  end

  factory :invitation, aliases: [:family_invitation] do
    family_id 1
    sender_id 1
    status "pending"
    sequence(:email){ |n| "e.wadsworth#{n}@gmail.com" }
    sequence(:name) { |n| "Emily Wadsworth #{n}" }
  end
end
