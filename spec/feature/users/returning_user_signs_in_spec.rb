require "rails_helper"

feature "returning user signs in" do

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    OmniAuth.config.mock_auth[:google_oauth2] = {
      "provider" => user.provider,
      "uid" => user.uid,
      "info" => {
        "email" => user.email,
        "name" => user.name,
        "first_name" => user.first_name,
        "last_name" => user.last_name,
        "image"=> user.image
      }
    }
  end

  scenario "sign in with google credentials" do
    visit root_path
    click_link "Sign In With Google"

    expect(page).to have_content("Signed in as #{user.name}")
    expect(page).to have_link("Sign Out", session_path)

    expect(User.count).to eq(1)
  end

  scenario "sign out" do
    visit root_path
    click_link "Sign In With Google"

    expect(page).to have_content("Signed in as #{user.name}")

    click_link "Sign Out"

    expect(page).to_not have_content("Signed in as #{user.name}")
    expect(page).to have_content("Signed out successfully.")
  end

end
