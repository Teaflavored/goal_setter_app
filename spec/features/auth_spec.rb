# spec/features/auth_spec.rb
require 'rails_helper'

feature "the signup process" do 

  it "has a new user page" do
    visit new_user_url
    
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do
    
    it "should display error messages for invalid signup" do
      visit new_user_url
      fill_in "Username", with: ""
      fill_in "Password", with: ""
      click_button "Sign Up"
      
      expect(page).to have_content("Sign Up")
      expect(page).to have_content("Username can't be blank")
      expect(page).to have_content("Password is too short")
    end
    
    it "shows username on the homepage after signup" do
      visit root_url
      click_link "Sign Up"
      fill_in "Username", with: "test_user"
      fill_in "Password", with: "password"
      click_button "Sign Up"
      
      expect(page).to have_content("test_user")
    end
  end

end

feature "logging in" do 
  given(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }
  it "shows username on the homepage after login" do    
    expect(page).to have_content(user.username)
  end
  
  it "doesn't show sign up link on home page" do
    visit root_url
    
    expect(page).not_to have_link("Sign Up")
  end
  
  it "shouldn't be able to access signing up" do
    visit new_user_url
    
    expect(page).to have_content("Home")
    expect(page).not_to have_content("Sign Up")
  end
  
  it "shouldn't be able to access signing in" do
    visit new_session_url
    
    expect(page).to have_content("Home")
    expect(page).not_to have_content("Sign In")
  end
end

feature "logging out" do 
  given(:user) { FactoryGirl.create(:user) }
  it "begins with logged out state" do
    visit root_url
    expect(page).not_to have_button("Sign Out")
    expect(page).to have_link("Sign In")
  end

  it "doesn't show username on the homepage after logout" do
    sign_in(user)
    click_button "Sign Out"
    
    expect(page).not_to have_content(user.username)
    expect(page).to have_link("Sign In")
  end
end

