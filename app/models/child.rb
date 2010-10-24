class Child < ActiveRecord::Base

  belongs_to :user
  has_many :sleep_blocks, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false, :scope => :user_id}

  before_save :set_parameterized_name

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
