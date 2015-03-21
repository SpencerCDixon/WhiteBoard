require "rails_helper"

feature "visitor creates account" do

  before :each do
    # This suppresses any warnings from polluting the test output.
    # http://stackoverflow.com/questions/19483367/rails-omniauth-error-in-rspec-output
    OmniAuth.config.logger = Logger.new("/dev/null")
  end

  scenario "successful sign up with valid google credentials" do
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

   scenario "failure to sign up with invalid credentials" do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

    visit root_path

    click_link "Sign In With Google"

    expect(page).to have_content("Unable to sign in.")
    expect(page).to have_link("Sign In With Google", new_session_path)
    expect(User.count).to eq(0)
  end

end
