require 'rails_helper'

feature 'Signing Up', type: :feature do 
  background :each do
    visit new_user_url
  end

  scenario 'has a user sign up page' do 
    # save_and_open_page
    expect(page).to have_content("Sign Up")
  end

  scenario 'takes a username, password and age' do 
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
    expect(page).to have_content('Age')
  end

  scenario 'will redirect to user show page and display username on success' do
    fill_in 'Username', with: 'Cool Capy'
    fill_in 'Age', with: 270
    fill_in 'Password', with: 'ImSuperCappy'
    click_button 'Sign Up'
    
    expect(page).to have_content('Cool Capy')
    user = User.find_by(username: "Cool Capy")
    expect(current_path).to eq(user_path(user))
  end

  scenario 'rerenders sign up page with invalid user info' do 
    fill_in 'Username', with: 'Cool Capy'
    fill_in 'Age', with: 270
    click_button 'Sign Up'

    # save_and_open_page
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
  end
end