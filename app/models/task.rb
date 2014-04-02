class Task < ActiveRecord::Base
  belongs_to :group
  belongs_to :bit_player_content_module, class_name: "BitPlayer::ContentModule"
  belongs_to :creator, class_name: "User"
end
