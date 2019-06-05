require 'rails_helper'

feature "the signup", type: :feature do
  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signs up a new user" do
    scenario "with invalid params" do
      sign_up_user(nil, nil)

      expect(current_path).to eq("/users")
      expect(page).to have_content("Password is too short")
      expect(page).to have_content("Email can't be blank")
    end

    scenario "with valid params" do
      email = Faker::Internet.email
      sign_up_user(email, "starwars")

      expect(current_path).to eq("/session/new")
      expect(page).to have_content("Your account has been created.")
    end
  end
end
