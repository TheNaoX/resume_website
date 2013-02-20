require 'spec_helper'

describe Comment do
  before :each do
    @user = FactoryGirl.create(:user)
    @post = FactoryGirl.create(:post, author: @user)
  end
  context 'Create comments' do

    it 'should validate if the comment has text' do
      comment = Comment.new
      comment.save
      comment.errors.any?.should be_true
      comment.comment = "This text is not going to be publicated"
      comment.user_id = 1
      comment.post_id = 1
      comment.save.should be_true
    end

  end

  context 'Get info from comments' do

    it 'should return the username from the commenter' do
      comment = FactoryGirl.build(:comment, user: @user, post: @post)
      comment.save
      comment.username.should == "Awesome author"
      comment.userid.should == @user.id
    end

  end
end
