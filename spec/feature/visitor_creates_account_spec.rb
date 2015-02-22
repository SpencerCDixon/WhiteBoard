require "rails_helper"

feature "guest creates account" do

  scenario "successful sign up with valid github credentials" do
    OmniAuth.config.mock_auth[:google_oauth2] = {
      "provider" => "google_oauth2",
      "uid" => "123456",
      "info" => {
        "email" => "spencerdixon@example.com",
        "name" => "Spencer Dixon",
        "first_name" => "Spencer",
        "last_name" => "Dixon",
        "image"=>"https://lh6.googleusercontent.com/-AskbC7sGK7A/AAAAAAAAAAI/AAAAAAAAADA/nTDC13Uvcoc/photo.jpg?sz=50"
      }
    }

    visit root_path

    click_link "Sign In With Google"

    expect(page).to have_content("Signed in as Spencer Dixon")
    expect(page).to have_link("Sign Out", session_path)

    expect(User.count).to eq(1)
  end

end
