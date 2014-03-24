namespace :email_reminder do

  desc 'triggers email reminders'

  task :drip_email => :environment do

    Participant.active.each do |participant|

      participant.participant_emails.each do |email|

        case email.email_type
          when ParticipantEmail.phq9
            if (DateTime.current - 7.days) > email.last_email
              PhqMailer.reminder_email(participant).deliver
              email.last_email = DateTime.current
              email.save
            end
          else
              #TODO Log exception indicating that the type of email to deliver is not found in the ParticipantEmail enum type.
        end

      end
    end
  end
end