# A set of Participants.
class Group < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :memberships, dependent: :destroy
  has_many :participants, through: :memberships

  validates :title, presence: true, length: { maximum: 50 }
  validates :creator, presence: true
end
