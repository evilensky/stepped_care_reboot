# A set of Participants.
class Group < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :group_slideshow_joins
  has_many :bit_player_slideshows, through: :group_slideshow_joins
  has_many :memberships, dependent: :destroy
  has_many :active_memberships,
           -> { active },
           class_name: "Membership",
           foreign_key: :group_id,
           dependent: :destroy,
           inverse_of: :active_group
  has_many :tasks
  has_many :active_participants, through: :active_memberships

  validates :title, presence: true, length: { maximum: 50 }
  validates :creator, presence: true
end
