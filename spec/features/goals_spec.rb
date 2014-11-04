require 'rails_helper'

feature "CRUD for goals" do 
  given(:goal) { FactoryGirl.create(:goal) }
  given(:user) { goal.goal_setter }
  
  
  it "should only be accessible for logged in users" do
    visit user_url(user)
    
    expect(page).to have_content("Sign In")
  end
  
  it "has a new goal creation page" do
    sign_in(user)
    visit new_goal_url
    
    expect(page).to have_content("New Goal")
    expect(page).to have_button("Create New Goal")
  end
  
  it "has a edit goal creation page" do
    sign_in(user)
    visit edit_goal_url(goal)
    
    expect(page).to have_content("Edit Goal")
    expect(page).to have_button("Edit Goal")
  end
  
  it "goals show up on user's show page" do
    sign_in(user)
    visit user_url(user)
    
    expect(page).to have_content("All Goals")
  end
  
  it "has a goal show page" do
    sign_in(user)
    visit goal_url(goal)
    
    expect(page).to have_content(goal.content)
  end
  
end

feature "creating a goal" do
  given(:user) { FactoryGirl.create(:user) }
  
  it "goes to goal show page after creation" do
    sign_in(user)
    visit new_goal_url
    fill_in "Name", with: "cool new goal"
    fill_in "Content", with: "Become good at things"
    choose("Public")
    click_button("Create New Goal")
    
    expect(page).to have_content("cool new goal")
    expect(page).to have_content("Become good at things")
    expect(page).to have_content("Public")
    expect(page).to have_content("Incomplete")
  end
  
  it "doesn't move away for invalid creation" do
    sign_in(user)
    visit new_goal_url
    fill_in "Name", with: ""
    fill_in "Content", with: ""
    click_button("Create New Goal")
    
    expect(page).to have_content("New Goal")
    expect(page).to have_button("Create New Goal")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Goal type can't be blank")
  end

end

feature "editing a goal" do
  given(:goal) { FactoryGirl.create(:goal) }
  given(:user) { goal.goal_setter }
  
  it "should be able to edit a goal" do
    old_name = goal.name
    sign_in(user)
    visit edit_goal_url(goal)
    fill_in "Name", with: "New name"
    click_button("Edit Goal")
    
    expect(page).not_to have_button("Edit Goal")
    expect(page).to have_content("New name")
    expect(page).not_to have_css("h1.goal_name", text: old_name) #try to see if you don't need                                                   #local var
  end
end


feature "viewing goals" do
  given(:goal) { FactoryGirl.create(:goal) }
  given(:user) { goal.goal_setter }
  given(:goal2) { FactoryGirl.create(:goal) }
  given(:user2) { goal2.goal_setter }
  given(:goal3) { FactoryGirl.create(:private_goal) }
  given(:user3) { goal3.goal_setter }
  
  it "user should see all of their own goals" do
    sign_in(user)
    visit new_goal_url
    fill_in "Name", with: "new private goal"
    fill_in "Content", with: "new private goal content"
    choose("Private")
    click_button("Create New Goal")
    visit user_url(user)
    
    expect(page).to have_link(goal.name)
    expect(page).to have_link("new private goal")
  end
  
  it "user should not be able to see other people's private goals" do
    sign_in(user)
    visit user_url(user3)
    
    expect(page).not_to have_link(goal3.name)
  end
  
  it "user should be able to see other people's public goals" do
    sign_in(user)
    visit user_url(user2)
    
    expect(page).to have_link(goal2.name)
    expect(page).not_to have_link("Complete Goal!")
  end
  
end

feature "goal completion" do
  given(:goal) { FactoryGirl.create(:goal) }
  given(:user) { goal.goal_setter }
  
  given(:user2) { FactoryGirl.create(:user) }
  
  before do
    sign_in(user)
    visit user_url(user)
  end
  
  it "goal should have completed or not on user show page" do

    expect(page).to have_link(goal.name)
    expect(page).to have_link("Complete Goal!")
    expect(page).to have_content("Incomplete")
  end
  
  it "should be able to complete own feature" do
    click_link "Complete Goal!"
    
    expect(page).to have_content("Complete")
    expect(page).not_to have_link("Complete Goal!")
  end
  
  it "goal should have completed or not on show page" do
    click_link goal.name
    
    expect(page).to have_content(goal.content)
    expect(page).to have_content("Incomplete")
  end
  
  
end