class ParticipantEmail < ActiveRecord::Base
  belongs_to :participant, class_name:'Participant'

  enum email_type: [ :phq9 ]
end
