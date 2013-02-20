require 'spec_helper'

describe CommentsController do
  before :each do
    @user = FactoryGirl.create(:user)
    @post = FactoryGirl.create(:post, author: @user)
    sign_in @user
  end

  context '#create' do

    it 'should allow to create comments by post method' do
      post :create, { post_id: @post.id, user_id: @user.id, comment: 'text goes here' }
      ActiveSupport::JSON.decode(response.body)
    end

  end
  
end
