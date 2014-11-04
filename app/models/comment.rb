# == Schema Information
#
# Table name: commentables
#
#  id               :integer          not null, primary key
#  content          :text             not null
#  commentable_type :string(255)      not null
#  commentable_id   :integer          not null
#  author_id        :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base
  validates :commentable, :content, presence: true
  
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true
end
