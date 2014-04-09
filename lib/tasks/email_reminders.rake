namespace :email_reminders do

  desc "triggers weekly PHQ email reminder"
  task phq_assessment: :environment do
    day_of_the_week = Time.new.wday
    Participant.active.each do |participant|
      if participant.memberships.first.start_date.wday == day_of_the_week
        PhqAssessmentMailer.reminder_email(participant).deliver
      end
    end
  end
end
