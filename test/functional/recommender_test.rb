require 'test_helper'

class RecommenderTest < ActionMailer::TestCase
  test "sendEmail" do
    
    user = users(:peter).find
    
    mail = Recommender.sendEmail user, nil, user.email
    assert_equal "#{user.name}'s Birthday Gift Ideas", mail.subject
    assert_equal ["#{user.email}"], mail.to
    assert_equal ["giftedDemoApp@gmail.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
