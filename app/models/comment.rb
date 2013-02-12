class Comment < ActiveRecord::Base
  acts_as_api
  attr_accessible :comment, :post_id, :user_id

  belongs_to :user
  belongs_to :post

  validates_presence_of :comment, :post_id, :user_id

  api_accessible :post_details do |template|
    template.add :comment
    template.add :username
    template.add :userid
    template.add :created_at
    template.add :updated_at
  end

  def username
    self.user.username
  end

  def userid
    self.user.id
  end
  
end
