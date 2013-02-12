class Comment < ActiveRecord::Base
  attr_accessible :comment, :post_id, :user_id

  belongs_to :user
  belongs_to :post

  validates_presence_of :comment, :post_id, :user_id
end
