class GroupSlideshowJoin < ActiveRecord::Base

  belongs_to :bit_player_slideshow, :class_name => "BitPlayer::Slideshow"
  belongs_to :creator, :class_name => "User"
  belongs_to :group

  validates :bit_player_slideshow, :creator, :group, :release_day, presence: true

  # makes sure that a slideshow can't be assigned to a group on the same release day more than once
  validates_uniqueness_of :release_day,
    :message => 'This slideshow has already by assigned to be released on this day to this group.',
    :scope => [:bit_player_slideshow, :group]

end
