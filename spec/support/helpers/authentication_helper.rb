module AuthenticationHelper
  def sign_in_as(user)
    OmniAuth.config.mock_auth[:google_oauth2] = {
      "provider" => user.provider,
      "uid" => user.uid,
      "info" => {
        "email" => user.email,
        "name" => user.name,
        "first_name" => user.name,
        "last_name" => user.name,
        "image" => user.image
      }
    }

    visit root_path
    click_link "Sign In With Google"
  end
end
