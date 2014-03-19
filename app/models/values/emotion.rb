module Values
  # Participants rate their emotion with a valence and intensity
  class Emotion
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

end