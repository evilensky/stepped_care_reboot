Time::DATE_FORMATS.merge!(
  date_time_with_meridian: ->(time) { time.strftime("%B #{ time.day.ordinalize } @ %l%P") },
  time_with_meridian: '%l%P'
)
