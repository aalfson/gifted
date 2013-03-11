class Recommender < ActionMailer::Base
  default from: "giftedDemoApp@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.recommender.sendSampleEmail.subject
  #
  def sendSampleEmail
    @greeting = "Hi"

    mail to: "aaron.alfson@gmail.com", subject: "Test"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.recommender.sendEmails.subject
  #
  def sendEmails
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
