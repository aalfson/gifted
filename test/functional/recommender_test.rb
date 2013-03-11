require 'test_helper'

class RecommenderTest < ActionMailer::TestCase
  test "sendSampleEmail" do
    mail = Recommender.sendSampleEmail
    assert_equal "Sendsampleemail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "sendEmails" do
    mail = Recommender.sendEmails
    assert_equal "Sendemails", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
