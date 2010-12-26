class ActiveSupport::TimeZone

  def beginning_of_day(date)
    Time.zone.parse(date.to_s).beginning_of_day
  end

  def end_of_day(date)
    Time.zone.parse(date.to_s).end_of_day
  end

end
