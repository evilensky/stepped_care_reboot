class DeliveredMessage < ActiveRecord::Base
  belongs_to :message
  belongs_to :recipient, polymorphic: true

  validates :message, :recipient, presence: true
  validates :is_read, inclusion: { in: [true, false] }
end
