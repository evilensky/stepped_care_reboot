# The relationship of a Participant to a Group.
class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :active_group,
             class_name: "Group",
             foreign_key: :group_id,
             inverse_of: :active_memberships
  belongs_to :participant
  belongs_to :active_participant,
             class_name: "Participant",
             foreign_key: :participant_id,
             inverse_of: :active_membership

  validates :group, presence: true
  validates :participant, presence: true
  validates :group_id, uniqueness: { scope: :participant_id }

  def self.active
    sql = <<-SQL
            memberships.start_date IS NULL OR memberships.start_date <= ? AND
              memberships.end_date IS NULL OR memberships.end_date >= ?
          SQL

    where(sql, Date.today, Date.today)
  end
end
