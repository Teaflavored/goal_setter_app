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

require 'rails_helper'

RSpec.describe Comment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
