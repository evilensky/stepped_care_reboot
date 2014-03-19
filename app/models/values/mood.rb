module Values
  # Users rate their mood
  class Mood
    def self.from_rating(rating)
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