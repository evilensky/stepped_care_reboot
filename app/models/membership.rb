class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :participant

  validate :group, presence: true
  validate :participant, presence: true
  validates_uniqueness_of :group_id, scope: :participant_id
end
