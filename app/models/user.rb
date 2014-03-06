class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :coach_assignments, as: :coach, foreign_key: :coach_id
  has_many :messages, as: :sender
  has_many :messages, as: :recipient
end
