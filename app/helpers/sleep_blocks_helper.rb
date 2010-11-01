module SleepBlocksHelper

  def friendly_sleep_total(seconds)
    return "" if seconds.nil?
    hours = (seconds / 60.0 / 60.0).round(1)
    precision = (hours % 1.0 == 0.0) ? 0 : 1
    time = number_with_precision(hours, :precision => precision)
    pluralize(time, "hour")
  end

end
