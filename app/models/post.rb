class Post < ActiveRecord::Base
  attr_accessible :author_id, :content, :title

  belongs_to :author, class_name: User, primary_key: :author_id

  validates_presence_of :content, :title, :author_id
  validates :content, length: { minimum: 140, message: "Please be more descriptive with the message" }
end
