class Values::Emotion

  def self.from_activation_level(activation_level)
    self.from_rating(activation_level)
  end

  def self.from_intensity(intensity)
    return "Not answered" if intensity.nil?
    if intensity < 0
      new("Low")
    elsif intensity == 0
      new("Average")
    else
      new("High")
    end
  end

  def self.from_rating(rating)
    return "Not answered" if rating.nil?
    if rating < 0
      new("Bad")
    elsif rating == 0
      new("Neither")
    else
      new("Good")
    end
  end

  def initialize(label)
    @label = label
  end

  def to_s
    @label.to_s
  end

end