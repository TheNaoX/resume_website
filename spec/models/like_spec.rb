require 'spec_helper'

describe Like do

  before :each do
    @user = FactoryGirl.create(:user)
    @post = FactoryGirl.create(:post, author: @user)
  end

  context 'users likes' do
    it 'Should allow the user to like just once the post' do
      Like.create(post_id: @post.id, user_id: @user.id)
      Like.create(post_id: @post.id, user_id: @user.id).should raise_error
    end
  end

end
