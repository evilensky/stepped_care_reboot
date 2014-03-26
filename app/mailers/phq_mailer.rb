# Sends a PHQ9 email reminder to a given participant.
class PhqMailer < ActionMailer::Base
  layout 'email'

  default from: 'stepcare@northwestern.edu'

  def reminder_email(participant)
    @participant = participant
    @participant_token = ParticipantToken.create(participant_id: participant.id, token_type: "phq9", release_date: DateTime.now.to_i)

    mail(to: @participant.email,
         subject: 'PHQ-9 Reminder')
  end
end
