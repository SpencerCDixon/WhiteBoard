require 'rails_helper'

feature 'can visit hoempage' do
  scenario 'successfully' do
    visit root_path
    expect(page).to have_content("Welcome")
  end
end
