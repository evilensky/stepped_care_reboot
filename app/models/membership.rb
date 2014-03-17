# The relationship of a Participant to a Group.
class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :participant

  validates :group, presence: true
  validates :participant, presence: true
  validates_uniqueness_of :group_id, scope: :participant_id
end
