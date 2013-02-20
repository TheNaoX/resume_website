require 'spec_helper'

describe Post do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  context 'Validations' do
    it 'should validate the length of the text and the author' do
      post = Post.new(title: 'Another awesome title', content: 'Another awesome content', author_id: @user.id)
      post.save.should be_false
      post.content = "My awesome content for my awesome post because of course I'm such a great blogger and narcisist and everyone hates me, I supposed that the validations will fail because of the content, but I just don't care I can keep writing and writing until the test pass, doesn't matter..."
      post.save.should be_true
    end
  end

  context 'Pretty print likes' do
    it 'should print likes in a beautiful format' do
      post = FactoryGirl.create(:post, author: @user)
      post.likes.count == 0
      post.pretty_print_likes.should == "<i class='icon-thumbs-up'></i>Be the first of your friends to like this."
      post.likes << Like.new(user_id: @user.id)
      post.likes.count == 1
      post.pretty_print_likes.should == "<i class='icon-thumbs-up'></i>#{@user.username} likes this."
    end
  end
end
