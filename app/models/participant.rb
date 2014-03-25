# A person enrolled in the intervention.
class Participant < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :activities, dependent: :destroy
  has_many :awake_periods, dependent: :destroy
  has_many :activity_types, dependent: :destroy
  has_many :emotions, dependent: :destroy
  has_many :moods, dependent: :destroy
  has_many :thoughts, dependent: :destroy
  has_many :sent_messages, class_name: 'Message', as: :sender
  has_many :messages, as: :sender
  has_many :received_messages,
           -> { includes :message },
           class_name: 'DeliveredMessage',
           as: :recipient
  has_one :participant_status, class_name: 'BitPlayer::ParticipantStatus'
  has_one :coach_assignment
  has_one :coach, class_name: 'User', through: :coach_assignment

  def unplanned_activities
    UnplannedActivities.new(self)
  end

  def build_data_record(association, attributes)
    send(association).build(attributes)
  end

  def fetch_data_record(association, id)
    send(association).find(id)
  end

  def navigation_status
    participant_status || build_participant_status
  end

  def recent_activities
    # when no awake period return an empty set to allow chaining
    now = Time.new
    start_time = recent_awake_period.try(:start_time) || now
    end_time = recent_awake_period.try(:end_time) || now

    activities.during(start_time, end_time)
  end

  def recent_pleasurable_activities
    recent_activities.pleasurable
  end

  def recent_accomplished_activities
    recent_activities.accomplished
  end

  def recent_awake_period
    @recent_awake_period ||= awake_periods.order('start_time').last
  end

  scope :active, lambda {
    where('participant.end_date IS NULL OR participant.end_date > ?', Time.now)
  }
end
