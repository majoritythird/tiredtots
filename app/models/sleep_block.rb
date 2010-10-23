class SleepBlock < ActiveRecord::Base

  belongs_to :child

  validates :start_string, :presence => { :unless => :start_invalid? }
  validate :format_of_start_time
  validate :format_of_finish_time

  scope :unfinished, where(:finish_time => nil)

  attr_accessor :start_invalid
  alias start_invalid? start_invalid

  def start_string=(start_string)
    return if start_string.blank?
    @start_string = start_string
    parsed_time = Chronic.parse(start_string)
    if parsed_time.present?
      self.start_time = parsed_time
    else
      self.start_invalid = true
    end
  rescue ArgumentError
    self.start_invalid = true
  end

  def finish_string=(finish_string)
    return if finish_string.blank?
    @finish_string = finish_string
    parsed_time = Chronic.parse(finish_string)
    if parsed_time.present?
      self.finish_time = parsed_time
    else
      @finish_invalid = true
    end
  rescue ArgumentError
    @finish_invalid = true
  end

  def start_string
    start_time.try(:to_s, :brief) || @start_string
  end

  def finish_string
    finish_time.try(:to_s, :brief) || @finish_string
  end

  def self.human_attribute_name(name, options = {})
    name = name.to_s
    {'start_string' => 'Start time', 'finish_string' => 'Finish time'}[name] || name.humanize
  end

  protected

  def format_of_start_time
    errors.add(:start_time, "is invalid") if start_invalid
  end

  def format_of_finish_time
    errors.add(:finish_time, "is invalid") if @finish_invalid
  end

end
