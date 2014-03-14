class Values::Emotion

  def self.from_activation_level(activation_level)
    return "Not answered" if activation_level.nil?
    case activation_level
    when -5
      new("Bad")
    when -4
      new("Boppy")
    when -3
      new("Grumpy")
    when -2
      new("Fatigued")
    when -1
      new("Depressed")
    when 0
      new("Happy")
    when 1
      new("Bad")
    when 2
      new("Boppy")
    when 3
      new("Grumpy")
    when 4
      new("Fatigued")
    when 5
      new("Depressed")
    end
  end

  def self.from_intensity(intensity)
    return "Not answered" if intensity.nil?
    if intensity < 5
      new("Low")
    elsif intensity == 5
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