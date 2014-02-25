class Participant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :activities, dependent: :destroy
  has_many :awake_periods, dependent: :destroy

  def build_data_record(association, attributes)
    send(association).build(attributes)
  end

  def recent_activities
    if recent_awake_period
      activities.during(recent_awake_period.start_time, recent_awake_period.end_time)
    else
      []
    end
  end

  def recent_awake_period
    awake_periods.order('start_time').last
  end
end
