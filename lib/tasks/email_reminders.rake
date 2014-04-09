namespace :email_reminders do

  desc "triggers weekly PHQ email reminder"
  task phq_assessment: :environment do
    day_of_the_week = Time.new.wday
    Membership.active.each do |membership|
      if membership.start_date.wday == day_of_the_week
        PhqAssessmentMailer.reminder_email(membership.participant).deliver
      end
    end
  end
end
