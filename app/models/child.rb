class Child < ActiveRecord::Base

  belongs_to :user
  has_many :sleep_blocks, :order => :start_time, :dependent => :destroy
  has_many :tracked_days, :order => 'for_date desc'

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false, :scope => :user_id}

  before_save :set_parameterized_name

  def no_data_for_time_block(time)
    sleep_blocks.finished.none? {|block| block.start_time.to_i < time.to_i} || sleep_blocks.finished.none? {|block| block.finish_time.to_i > time.to_i}
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
