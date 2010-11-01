class Child < ActiveRecord::Base

  belongs_to :user
  has_many :sleep_blocks, :order => :start_time, :dependent => :destroy
  has_many :tracked_days, :order => :for_date

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false, :scope => :user_id}

  before_save :set_parameterized_name

  def no_data_for_time_block(time)
    sleep_blocks.finished.none? {|block| block.start_time < time} || sleep_blocks.finished.none? {|block| block.finish_time > time}
  end

  def sleep_block_covering(time)
    sleep_blocks.finished.select do |block|
      block.start_time <= time && block.finish_time >= time
    end.first
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

end
