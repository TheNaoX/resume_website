class Post < ActiveRecord::Base

  attr_accessible :author_id, :content, :title, :link

  belongs_to :author, class_name: User, foreign_key: :author_id

  validates_presence_of :content, :title, :author_id
  validates :content, length: { minimum: 140, message: "Please be more descriptive with the message" }
  validates :title, uniqueness: { message: "This post already exists" }
  validates :link, format: { with: URI::regexp(%w(http https)), message: "Please enter valid link" }

  default_scope order('created_at DESC')
end
