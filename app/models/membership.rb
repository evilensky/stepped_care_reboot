# The relationship of a Participant to a Group.
class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :participant

  validates :group, presence: true
  validates :participant, presence: true
  validates :group_id, scope: :participant_id, uniqueness: true
end
