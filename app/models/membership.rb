# The relationship of a Participant to a Group.
class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :participant

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
