# A person enrolled in the intervention.
class Participant < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_one :active_membership,
          -> { active },
          class_name: "Membership",
          foreign_key: :participant_id,
          dependent: :destroy,
          inverse_of: :active_participant
  has_many :groups, through: :memberships
  has_one :active_group, through: :active_membership
  has_many :activities, dependent: :destroy
  has_many :awake_periods, dependent: :destroy
  has_many :activity_types, dependent: :destroy
  has_many :emotions, dependent: :destroy
  has_many :moods, dependent: :destroy
  has_many :thoughts, dependent: :destroy
  has_many :sent_messages, class_name: "Message", as: :sender
  has_many :messages, as: :sender
  has_many :received_messages,
           -> { includes :message },
           class_name: "DeliveredMessage",
           as: :recipient
  has_many :phq_assessments, dependent: :destroy
  has_many :participant_tokens, dependent: :destroy
  has_one :participant_status, class_name: "BitPlayer::ParticipantStatus"
  has_one :coach_assignment
  has_one :coach, class_name: "User", through: :coach_assignment

  def current_group
    membership.group
  end

  def self.active
    joins(:memberships).merge(Membership.active)
  end

  def unplanned_activities
    UnplannedActivities.new(self)
  end

  def build_data_record(association, attributes)
    send(association).build(attributes)
  end

  def fetch_data_record(association, id)
    send(association).find(id)
  end

  def membership
    # Currently, a participant is assigned to 1 group
    memberships.first
  end

  def navigation_status
    participant_status || build_participant_status
  end

  def recent_activities
    activities.during(recent_period[:start_time], recent_period[:end_time])
  end

  def recent_pleasurable_activities
    recent_activities.pleasurable
  end

  def recent_accomplished_activities
    recent_activities.accomplished
  end

  def build_phq_assessment(attributes)
    phq_assessments.build(attributes)
  end

  def tasks_to_complete(content_modules)
    membership.task_statuses
      .where(completed_at: nil)
      .joins(:task)
      .where("tasks.release_day <= ?", membership.day_in_study)
      .for_content_modules(content_modules.map(&:id))
  end

  private

  def recent_period
    @recent_period ||= (
      # when no awake period return an empty set to allow chaining
      now = Time.new
      start_time = recent_awake_period.try(:start_time) || now
      end_time = recent_awake_period.try(:end_time) || now

      { start_time: start_time, end_time: end_time }
    )
  end

  def recent_awake_period
    @recent_awake_period ||= awake_periods.order("start_time").last
  end
end
