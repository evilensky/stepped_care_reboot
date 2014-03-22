class GroupSlideshowJoin < ActiveRecord::Base

  belongs_to :bit_player_slideshow, :class_name => "BitPlayer::Slideshow", dependent: :destroy
  belongs_to :creator, :class_name => "User"
  belongs_to :group, dependent: :destroy

  validates :bit_player_slideshow, :creator, :group, :release_day, presence: true

end
