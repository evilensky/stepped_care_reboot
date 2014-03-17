# Mailer for notifying of new application messages.
class MessageNotifications < ActionMailer::Base
  default from: "from@example.com"

  def new_for_coach(coach)
    mail to:      coach.email,
         subject: "New message"
  end
end
