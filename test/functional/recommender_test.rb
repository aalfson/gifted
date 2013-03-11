require 'test_helper'

class RecommenderTest < ActionMailer::TestCase
  test "sendEmail" do
    mail = Recommender.sendEmail
    assert_equal "Sendemail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
