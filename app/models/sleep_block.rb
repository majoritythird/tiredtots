class SleepBlock < ActiveRecord::Base

  belongs_to :child

  validates :start_string, :presence => { :unless => :start_invalid? }
  validate :format_of_start
  validate :format_of_finish

  scope :unfinished, where(:finish => nil)

  attr_accessor :start_invalid
  alias start_invalid? start_invalid

  def start_string=(start_string)
    return if start_string.blank?
    @start_string = start_string
    parsed_time = Chronic.parse(start_string)
    if parsed_time.present?
      self.start = parsed_time
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
      self.finish = parsed_time
    else
      @finish_invalid = true
    end
  rescue ArgumentError
    @finish_invalid = true
  end

  def start_string
    start.try(:to_s, :brief) || @start_string
  end

  def finish_string
    finish.try(:to_s, :brief) || @finish_string
  end

  def self.human_attribute_name(name, options = {})
    name = name.to_s
    {'start_string' => 'Start', 'finish_string' => 'Finish'}[name] || name.humanize
  end

  protected

  def format_of_start
    errors.add(:start, "is invalid") if start_invalid
  end

  def format_of_finish
    errors.add(:finish, "is invalid") if @finish_invalid
  end

end
