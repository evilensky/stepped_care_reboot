class Message < ActiveRecord::Base
  belongs_to :sender, polymorphic: true
  belongs_to :recipient, polymorphic: true
  has_many :delivered_messages

  validates :subject, :sender, :recipient, presence: true

  before_create :populate_sent_at
  after_create :create_delivered_messages

  private

  def populate_sent_at
    self.sent_at = Time.new
  end

  def create_delivered_messages
    recipient.received_messages.create(message_id: id)
  end
end