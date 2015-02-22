require "rails_helper"

describe User do
  describe ".find_or_create_from_omniauth" do
    let(:uid) { "123456" }
    let(:provider) { "google_oauth2" }

    let(:auth_hash) do
      {
        "provider" => provider,
        "uid" => uid,
        "info" => {
          "email" => "spencerdixon@example.com",
          "name" => "Spencer Dixon",
          "first_name" => "Spencer",
          "last_name" => "Dixon",
          "image"=>"https://lh6.googleusercontent.com/-AskbC7sGK7A/AAAAAAAAAAI/AAAAAAAAADA/nTDC13Uvcoc/photo.jpg?sz=50"
        }
      }
    end

    it "creates a new user" do
      user = User.find_or_create_from_omniauth(auth_hash)

      expect(user.uid).to eq(uid)
      expect(user.provider).to eq(provider)

      expect(user.email).to eq("spencerdixon@example.com")
      expect(user.name).to eq("Spencer Dixon")
      expect(user.first_name).to eq("Spencer")
      expect(user.last_name).to eq("Dixon")
      expect(user.image).to eq("https://lh6.googleusercontent.com/-AskbC7sGK7A/AAAAAAAAAAI/AAAAAAAAADA/nTDC13Uvcoc/photo.jpg?sz=50")

      expect(User.count).to eq(1)
    end

    it "finds an existing user" do
      FactoryGirl.create(:user, uid: uid, provider: provider)

      user = User.find_or_create_from_omniauth(auth_hash)
      expect(user.uid).to eq(uid)

      expect(User.count).to eq(1)
    end
  end
end
