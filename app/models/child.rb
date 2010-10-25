class Child < ActiveRecord::Base

  belongs_to :user
  has_many :sleep_blocks, :order => :start_time, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false, :scope => :user_id}

  before_save :set_parameterized_name

  def sleep_block_covering(time)
    sleep_blocks.finished.select do |block|
      block.start_time <= time && block.finish_time >= time
    end.first
  end

  def sleep_data_range
    last = sleep_blocks.last
    end_date = last.finish_time ? last.finish_time.to_date : last.start_time.to_date
    (sleep_blocks.first.start_time.to_date..end_date)
  end

  def no_data_for_time_block(time)
    sleep_blocks.finished.none? {|block| block.start_time < time} || sleep_blocks.finished.none? {|block| block.finish_time > time}
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
