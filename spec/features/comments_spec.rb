require 'rails_helper'

feature "showing comments" do
  given(:user_comment) { FactoryGirl.create(:user_comment) }
  given(:author) { user_comment.author }
  
  given(:goal_comment) { FactoryGirl.create(:goal_comment) }
  given(:author2) { goal_comment.author }
  
  it "shows comments on user show page" do
    sign_in(author)
    visit user_url(user_comment.recipient)
    
    expect(page).to have_css("h2", text: "All comments" )
    expect(page).to have_content(user_comment.content)
  end
  
  it "shows comments on the goal show page" do
    sign_in(author2)
    visit goal_url(goal_comment.goal)
    
    expect(page).to have_css("h2", text: "All comments")
    expect(page).to have_content(goal_comment.content)
  end
end

feature "creating a comment" do
  let(:user) { FactoryGirl.create(:user) }
  let(:goal) { FactoryGirl.create(:goal) }
  let(:user2) { goal.goal_setter }
  
  it "has a form on the user show page" do
    sign_in(user)
    visit user_url(user2)
    
    expect(page).to have_content("Add A Comment")
    expect(page).to have_button("Comment!")
  end
  
  it "has a form on the goal show page" do
    sign_in(user)
    visit goal_url(goal)
    
    expect(page).to have_content("Add A Comment")
    expect(page).to have_button("Comment!")
  end
  
  it "should be able to create a comment for user" do
    content = Faker::Hacker.say_something_smart
    sign_in(user)
    visit user_url(user2)
    fill_in "Content", with: content
    click_button "Comment!"
    
    expect(page).to have_content(content)
  end
  
  it "shouldn't create a comment if no content given for user" do
    content = Faker::Hacker.say_something_smart
    sign_in(user)
    visit user_url(user2)
    fill_in "Content", with: ""
    click_button "Comment!"
    
    expect(page).not_to have(content)
    expect(page).to have_content("Content can't be blank")
  end
  
  it "should be able to create a comment for goal" do
    content = Faker::Hacker.say_something_smart
    sign_in(user)
    visit goal_url(goal)
    fill_in "Content", with: content
    click_button "Comment!"
    
    expect(page).to have_content(content)
  end
  
  it "shouldn't create a comment if no content given for goal" do
    content = Faker::Hacker.say_something_smart
    sign_in(user)
    visit goal_url(goal)
    fill_in "Content", with: ""
    click_button "Comment!"
    
    expect(page).not_to have(content)
    expect(page).to have_content("Content can't be blank")
  end
  
end


feature "editing a comment" do
  given(:user_comment) { FactoryGirl.create(:user_comment) }
  given(:author) { user_comment.author }
  given(:user) { FactoryGirl.create(:user) }
  
  it "shouldn't be able to edit another user's comment" do
    sign_in(user)
    visit edit_comment_url(user_comment)
    
    expect(page).to have_content("Home")
  end
  
  it "should be able to edit own comment" do
    sign_in(author)
    old_content = user_comment.content
    visit user_url(user_comment.user)
    click_link("Edit Comment")
    fill_in "Content", with: "new content"
    click_button("Edit")
    
    expect(page).to have_content(user_comment.user.username)
    expect(page).to have_css("p", text: "new content")
    expect(page).not_to have_css("p", text: old_content)
  end
end