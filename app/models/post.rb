class Post < ActiveRecord::Base

  attr_accessible :author_id, :content, :title, :link

  belongs_to :author, class_name: User, foreign_key: :author_id
  has_many :likes

  validates_presence_of :content, :title, :author_id
  validates :content, length: { minimum: 140, message: "Please be more descriptive with the message" }
  validates :title, uniqueness: { message: "This post already exists" }
  validates :link, format: { with: URI::regexp(%w(http https)), message: "Please enter valid link" }

  default_scope order('created_at DESC')

  def pretty_print_likes
    if likes.count > 0
      likes_string = "<i class='icon-thumbs-up'></i>"
      likes_string += "#{likes.first.user.username}"
      likes_string += " and other #{likes.count - 1}" unless likes.count == 1
      likes_string += " likes this."
    else
      "<i class='icon-thumbs-up'></i>Be the first of your friends to like this."
    end
  end
end
