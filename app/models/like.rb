class Like < ActiveRecord::Base
  attr_accessible :post_id, :user_id
  
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :user_id, scope: :post_id  
end
