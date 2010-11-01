class SleepBlock < ActiveRecord::Base

  belongs_to :child

  validates :start_string, :presence => { :if => :start_valid? }
  validate :format_of_duration
  validate :format_of_start_time
  validate :format_of_finish_time
  validate :only_finish_time_or_duration
  validate :finish_after_start
  validate :no_overlap

  scope :covering, lambda { |date|
    where('start_time <= ?', date.to_time.end_of_day).
    where('finish_time >= ?', date.to_time.beginning_of_day)
  }
  scope :finished, where('finish_time IS NOT NULL')
  scope :unfinished, where(:finish_time => nil)

  after_save :update_tracked_days

  attr_accessor :duration
  attr_writer :start_valid

  def began_before(date)
    start_time < date.to_time.beginning_of_day
  end

  def began_on(date)
    start_time.to_date == date
  end

  def began_and_ended_on(date)
    began_on(date) && ended_on(date)
  end

  def began_before_and_ended_on(date)
    began_before(date) && ended_on(date)
  end

  def began_before_and_ended_after(date)
    began_before(date) && ended_after(date)
  end

  def began_on_and_ended_after(date)
    began_on(date) && ended_after(date)
  end

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

  def ended_after(date)
    finish_time > date.to_time.end_of_day
  end

  def ended_on(date)
    finish_time.to_date == date
  end

  def finished?
    finish_time.present?
  end

  def finish_string=(finish_string)
    @finish_string = finish_string
    return if finish_string.blank?
    begin
      parsed_time = Chronic.parse(finish_string, :context => :past)
    rescue RuntimeError
      parsed_time = Chronic.parse(finish_string, :context => :none)
    end
    if parsed_time.present?
      self.finish_time = parsed_time
    else
      @finish_invalid = true
    end
  rescue ArgumentError
    @finish_invalid = true
  end

  def self.human_attribute_name(name, options = {})
    name = name.to_s
    {'start_string' => 'Start time', 'finish_string' => 'Finish time'}[name] || name.humanize
  end

  def start_valid
    return true if @start_valid.nil?
    @start_valid
  end
  alias start_valid? start_valid

  def start_string
    @start_string || start_time.try(:to_s, :md_hm)
  end

  def finish_string
    @finish_string || finish_time.try(:to_s, :md_hm)
  end

  def start_string=(start_string)
    @start_string = start_string
    return if start_string.blank?
    begin
      parsed_time = Chronic.parse(start_string, :context => :past)
    rescue RuntimeError
      parsed_time = Chronic.parse(start_string, :context => :none)
    end
    if parsed_time.present?
      self.start_time = parsed_time
    else
      self.start_valid = false
    end
  rescue ArgumentError
    self.start_valid = false
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

  def update_tracked_days
    return unless finished?
    (start_time.to_date..finish_time.to_date).each do |date|
      child.tracked_days.find_or_initialize_by_for_date(date).recalculate
    end
  end

end
