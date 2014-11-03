# == Schema Information
#
# Table name: goals
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  content        :text             not null
#  goal_setter_id :integer          not null
#  completed      :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#  goal_type      :string(255)      not null
#

require 'rails_helper'

RSpec.describe Goal, :type => :model do
  let(:goal) { FactoryGirl.create(:goal) }
  
  describe "goal attributes" do
    it "should have all the valid attributes" do
      expect(goal).to respond_to(:name)
      expect(goal).to respond_to(:content)
      expect(goal).to respond_to(:goal_setter)
      expect(goal).to respond_to(:completed?)
      expect(goal).to respond_to(:goal_type)
    end
    
  end
  
  describe "associations" do
    it "should belong to a user" do
      expect(goal).to belong_to(:goal_setter)
    end
  end
  
  describe "Validations" do
    it { should validate_presence_of(:name) }
    
    it { should validate_presence_of(:content) }
    
    it { should validate_presence_of(:goal_setter_id) }
    
    it { should validate_presence_of(:goal_type) }
    
    it { should ensure_inclusion_of(:completed).in_array([true, false]) }
    
    it { should ensure_inclusion_of(:goal_type).in_array(["private", "public"])}
    
  end
  
end
