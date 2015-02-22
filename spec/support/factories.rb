FactoryGirl.define do
  factory :user do
    provider "google_oauth2"
    sequence(:uid) { |n| n }
    sequence(:email) { |n| "spencerdixon#{n}@gmail.com" }
    sequence(:name) { |n|  "Spencer Dixon #{n}" }
    image "https://lh6.googleusercontent.com/-AskbC7sGK7A/AAAAAAAAAAI/AAAAAAAAADA/nTDC13Uvcoc/photo.jpg?sz=50"
  end
end
