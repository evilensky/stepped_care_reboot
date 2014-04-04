class Task < ActiveRecord::Base
  belongs_to :group
  belongs_to :bit_player_content_module, class_name: "BitPlayer::ContentModule"
  belongs_to :creator, class_name: "User"

  scope :for_participant, lambda { |p| joins(:group => :memberships).where(:memberships => {:participant_id => p.id }) }
  scope :is_completed_for_participant, lambda { |p| where(is_complete: true).for_participant(p) }
  scope :to_be_completed_by_participant, lambda { |p| where(is_complete: false).for_participant(p) }
end