class Participant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # To alllow the user to change his password after logging in;
  # you have to use Devise::RegistrationsController#edit for that.
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :activities, dependent: :destroy
  has_many :awake_periods, dependent: :destroy
  has_many :activity_types, dependent: :destroy

  def build_data_record(association, attributes)
    send(association).build(attributes)
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
end
