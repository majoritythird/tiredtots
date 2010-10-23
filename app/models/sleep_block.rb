class SleepBlock < ActiveRecord::Base

  belongs_to :child

  validates :start, :presence => true

  validate :format_of_start

  scope :unfinished, where(:finish => nil)

  def start_string=(start_string)
    self.start = Chronic.parse(start_string)
  rescue ArgumentError
    @start_invalid = true
  end

  def start_string
    start.try(:to_s, :brief)
  end

  protected

  def format_of_start
    errors.add(:start, "is invalid") if @start_invalid
  end

end
