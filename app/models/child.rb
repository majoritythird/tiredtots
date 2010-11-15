class Child < ActiveRecord::Base

  belongs_to :user
  has_many :sleep_blocks, :order => :start_time, :dependent => :destroy
  has_many :tracked_days, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false, :scope => :user_id}

  before_save :set_parameterized_name

  def recent_tracked_days
    @recent_tracked_days ||= tracked_days.descending.recent.offset(1).reverse
  end

  def no_data_for_time_block(time)
    sleep_blocks.finished.none? {|block| block.start_time.to_i < time.to_i} || sleep_blocks.finished.none? {|block| block.finish_time.to_i > time.to_i}
  end

  def recent_sleep_average
    recent_tracked_days.to_a.sum(&:sleep_total) / recent_tracked_days.size
  end

  def recent_sleep_average_in_hours
    recent_sleep_average / 3600.0
  end

  def sleep_block_covering(time)
    time_ranges.each do |time_range|
      return true if time_range.cover?(time.to_i)
    end
    false
  end

  def sleep_data_range
    (tracked_days.first.for_date..tracked_days.last.for_date)
  end

  def to_param
    parameterized_name
  end

  def unfinished_sleep_block?
    sleep_blocks.unfinished.any?
  end

  protected

  def set_parameterized_name
    self.parameterized_name = name.parameterize
  end

  def time_ranges
    @time_ranges ||= sleep_blocks.finished.map { |block| (block.start_time.to_i..block.finish_time.to_i) }
  end

end
