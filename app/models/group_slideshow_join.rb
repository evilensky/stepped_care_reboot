# This is the object that holds what groups are assigned to what slideshows
# and when the slideshows are released to the group
class GroupSlideshowJoin < ActiveRecord::Base
  belongs_to :bit_player_slideshow, class_name: "BitPlayer::Slideshow"
  belongs_to :creator, class_name: "User"
  belongs_to :group

  validates :bit_player_slideshow, :creator, :group, :release_day,
            presence: true
  # This validation makes sure that a slideshow can't be assigned
  # to a group on the same release day more than once
  validates :release_day,
            uniqueness: {
              scope: [:bit_player_slideshow, :group],
              message: %q(This slideshow has already been assigned and set to
                          be released on this day to this group.)
            }
end
