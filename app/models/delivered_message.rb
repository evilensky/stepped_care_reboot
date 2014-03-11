class DeliveredMessage < ActiveRecord::Base
  belongs_to :message
  belongs_to :recipient, polymorphic: true

  validates :message, :recipient, presence: true
  validates :is_read, inclusion: { in: [true, false] }

  scope :unread, -> { where(is_read: false) }

  delegate :subject, :body, :render_body, to: :message

  def mark_read
    update(is_read: true)
  end
end
