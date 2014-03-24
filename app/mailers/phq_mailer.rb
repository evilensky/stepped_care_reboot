class PhqMailer < ActionMailer::Base
  layout 'email'

  default from: 'stepcare@northwestern.edu'

  def reminder_email(participant)
    @participant = participant

    mail(      to: @participant.email,
          subject: 'PHQ-9 Reminder')
  end
end
