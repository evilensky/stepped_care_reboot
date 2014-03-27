# Used to change color of table row based on emotion
module EmotionsHelper
  def emotion_class(emotion)
    case emotion.rating
    when 0..4
      "danger"
    when 6..10
      "success"
    else
      ""
    end
  end
end