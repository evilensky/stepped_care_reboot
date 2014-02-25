class Time

  def round(seconds = 60)
    Time.at((self.to_f / seconds).round * seconds)
  end

  def floor(seconds = 60)
    Time.at((self.to_f / seconds).floor * seconds)
  end

  def round_to_closest_hour
    if self.min > 30
      self.round(1.hour)
    else
      self.floor(1.hour)
    end
  end
end