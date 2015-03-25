require 'rails_helper'

describe FamilyBuilder do
  describe '#user_has_family?' do
    it 'returns true if yes' do
      user = FactoryGirl.create(:family_membership).user
      family_params = { name: "dixon" }
      builder = FamilyBuilder.new(family_params, user)

      expect(builder.send(:user_has_family?)).to eq true
    end

    it 'returns false if no' do
      user = FactoryGirl.create(:user)
      family_params = { name: "dixon" }
      builder = FamilyBuilder.new(family_params, user)

      expect(builder.send(:user_has_family?)).to eq false
    end
  end

  describe "#create_family_with_memberships" do
    it 'creates a new family' do
      user = FactoryGirl.create(:user)
      family_params = { name: "dixon" }

      builder = FamilyBuilder.new(family_params, user)
      families = Family.count

      builder.send(:create_family_with_membership)
      expect(Family.count).to eq (families + 1)
    end

    it 'creates family membership associated with family' do
      user = FactoryGirl.create(:user)
      family_params = { name: "dixon" }

      builder = FamilyBuilder.new(family_params, user)
      membership_count = FamilyMembership.count

      builder.send(:create_family_with_membership)
      expect(FamilyMembership.count).to eq (membership_count + 1)
    end
  end

  describe "#build" do
    it "returns false if user has a family already" do
      user = FactoryGirl.create(:family_membership).user
      family_params = { name: "dixon" }

      builder = FamilyBuilder.new(family_params, user)
      expect(builder.build).to eq false
    end

    it "returns true if user didn't have family" do
      user = FactoryGirl.create(:user)
      family_params = { name: "dixon" }

      builder = FamilyBuilder.new(family_params, user)
      expect(builder.build).to eq true
    end
  end
end
