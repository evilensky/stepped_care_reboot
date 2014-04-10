# A person with some authoritative role (a non-Participant).
class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :coach_assignments, foreign_key: :coach_id
  has_many :participants, through: :coach_assignments
  has_many :sent_messages, class_name: "Message", as: :sender
  has_many :group_slideshow_joins, foreign_key: :creator_id
  has_many :tasks, foreign_key: :creator_id
  has_many :messages, as: :sender
  has_many :received_messages,
           -> { includes :message },
           class_name: "DeliveredMessage",
           as: :recipient
  accepts_nested_attributes_for :coach_assignments
end
