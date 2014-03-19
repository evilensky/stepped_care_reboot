module EmotionsHelper

  def emotion_class(emotion)
    case emotion.rating
    when -5..-1
      "danger"
    when 1..5
      "success"
    else
      ""
    end
  end

end
