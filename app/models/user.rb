class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :coach_assignments, inverse_of: :coach, foreign_key: :coach_id
  has_many :participants, through: :coach_assignments
  has_many :sent_messages, class_name: 'Message', as: :sender
  has_many :messages, as: :sender
  has_many :received_messages,
           -> { includes :message },
           class_name: 'DeliveredMessage',
           as: :recipient
end
