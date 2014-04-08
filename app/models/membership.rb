# The relationship of a Participant to a Group.
class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :participant
  has_many :tasks, class_name: "TaskStatus"

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

  def day_in_study
    Date.now - start_date
  end
end
