class DeliveredMessage < ActiveRecord::Base
  belongs_to :message
  belongs_to :recipient, polymorphic: true

  validates :message, :recipient, presence: true
  validates :is_read, inclusion: { in: [true, false] }

  after_create :deliver_emails

  scope :unread, -> { where(is_read: false) }

  delegate :subject, :body, :render_body, to: :message

  def mark_read
    update(is_read: true)
  end

  private

  def deliver_emails
    if recipient.instance_of? User
      begin
        MessageNotifications.new_for_coach(recipient).deliver
      rescue
        # swallow exception
      end
    end
  end
end
