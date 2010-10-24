class SleepBlock < ActiveRecord::Base

  belongs_to :child

  validates :start_string, :presence => { :if => :start_valid? }
  validate :format_of_duration
  validate :format_of_start_time
  validate :format_of_finish_time
  validate :only_finish_time_or_duration

  scope :unfinished, where(:finish_time => nil)
  scope :finished, where('finish_time IS NOT NULL')

  attr_accessor :duration
  attr_writer :start_valid

  def start_valid
    return true if @start_valid.nil?
    @start_valid
  end
  alias start_valid? start_valid

  def duration=(duration_string)
    @duration = duration_string
    return if duration_string.blank? || @start_string.blank?
    duration_string.concat(":00") if duration_string =~ /^\d+:\d+$/
    parsed_duration = ChronicDuration.parse(duration_string)
    if parsed_duration.present?
      self.finish_time = start_time + parsed_duration.seconds
    else
      @duration_invalid = true
    end
  end

  def start_string=(start_string)
    @start_string = start_string
    return if start_string.blank?
    parsed_time = Chronic.parse(start_string)
    if parsed_time.present?
      self.start_time = parsed_time
    else
      self.start_valid = false
    end
  rescue ArgumentError
    self.start_valid = false
  end

  def finish_string=(finish_string)
    @finish_string = finish_string
    return if finish_string.blank?
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
    return @start_string if !@start_string.nil?
    start_time.try(:to_s, :md_hm) || @start_string
  end

  def finish_string
    finish_time.try(:to_s, :md_hm) || @finish_string
  end

  def self.human_attribute_name(name, options = {})
    name = name.to_s
    {'start_string' => 'Start time', 'finish_string' => 'Finish time'}[name] || name.humanize
  end

  def to_s
    if finish_time
      "#{start_time.to_s(:md_hm)} - #{finish_time.to_s(:md_hm)}"
    else
      "#{start_time.to_s(:md_hm)} - (unfinished)"
    end
  end

  protected

  def format_of_duration
    errors.add(:duration, "is invalid") if @duration_invalid
  end

  def format_of_start_time
    errors.add(:start_time, "is invalid") unless start_valid
  end

  def format_of_finish_time
    errors.add(:finish_time, "is invalid") if @finish_invalid
  end

  def only_finish_time_or_duration
    errors[:base] << "Please provide a finish time or a duration, but not both" if @finish_string.present? && duration.present?
  end

end
