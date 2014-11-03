require 'rails_helper'

feature "overall site" do
  it "it works" do
    visit root_url
    click_link "Sign Up"
    fill_in "Username", with: "tom"
    fill_in "Password", with: "tomtom"
    click_button "Sign Up"
    click_button "Sign Out"
    click_link "Sign In"
    fill_in "Username", with: "tom"
    fill_in "Password", with: "tomtom"
    click_button "Sign In"
    click_link("Profile")
    click_link("Create New Goal")
    fill_in "Name", with: "cool new goal"
    fill_in "Content", with: "Become good at things"
    choose("Public")
    click_button("Create New Goal")
    click_link("Back to Profile")
    
    expect(page).to have_link("cool new goal")
    
  end
end