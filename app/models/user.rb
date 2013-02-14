class User < ActiveRecord::Base
  acts_as_api
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  has_many :posts, foreign_key: :author_id
  has_many :likes
  has_many :comments
  
  validates_presence_of :username

  api_accessible :post_details do |template|
    template.add :id
    template.add :email
    template.add :username
    template.add :created_at
    template.add :updated_at
  end
end
