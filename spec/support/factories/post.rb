FactoryGirl.define do
  factory :post do
    title   'My awesome post about life and code'
    content "My awesome content for my awesome post because of course I'm such a great blogger and narcisist and everyone hates me, I supposed that the validations will fail because of the content, but I just don't care I can keep writing and writing until the test pass, doesn't matter..."
    link    'http://www.youtube.com/watch?v=4XpnKHJAok8'
  end
end
