namespace :email_reminder do

  desc 'triggers email reminders'

  task :drip_email => :environment do
    Participant.active.each do |participant|
      if Time.new.wday == participant.start_date.wday
        PhqMailer.reminder_email(participant).deliver
      end
    end
  end

end