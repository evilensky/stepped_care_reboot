class Message < ActiveRecord::Base
  belongs_to :sender, polymorphic: true
  belongs_to :recipient, polymorphic: true

  validates :subject, :sender, :recipient, presence: true

  before_create :populate_sent_at

  private

  def populate_sent_at
    self.sent_at = Time.new
  end
end
