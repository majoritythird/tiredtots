class SleepBlock < ActiveRecord::Base

  belongs_to :child

  validates :start_string, :presence => { :if => :start_valid? }
  validate :format_of_duration
  validate :format_of_start_time
  validate :format_of_finish_time
  validate :only_finish_time_or_duration
  validate :finish_after_start
  validate :no_overlap

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
    @start_string || start_time.try(:to_s, :md_hm)
  end

  def finish_string
    @finish_string || finish_time.try(:to_s, :md_hm)
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

  def finish_after_start
    errors[:base] << "Sleep can't end before it begins" if finish_time && finish_time <= start_time
  end

  def format_of_duration
    errors.add(:duration, "is invalid") if @duration_invalid
  end

  def format_of_finish_time
    errors.add(:finish_time, "is invalid") if @finish_invalid
  end

  def format_of_start_time
    errors.add(:start_time, "is invalid") unless start_valid
  end

  def no_overlap
    finish_before_count = child.sleep_blocks.where("finish_time <= ?", start_time).count
    start_after_count = child.sleep_blocks.where("start_time >= ?", finish_time).count
    total_count = if id.nil?
      child.sleep_blocks.count
    else
      child.sleep_blocks.where('sleep_blocks.id != ?', id).count
    end
    if ((finish_before_count + start_after_count) < total_count)
      errors[:base] << "Sleep can't overlap existing blocks of sleep"
    end
  end

  def only_finish_time_or_duration
    errors[:base] << "Please provide a finish time or a duration, but not both" if @finish_string.present? && duration.present?
  end

end
