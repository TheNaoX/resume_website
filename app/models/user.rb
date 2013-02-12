class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  has_many :posts, foreign_key: :author_id
  has_many :likes
  
  validates_presence_of :username
end
