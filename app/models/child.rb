class Child < ActiveRecord::Base

  belongs_to :user
  has_many :sleep_blocks

  validates :name, :presence => true

  def unfinished_sleep_block?
    sleep_blocks.unfinished.any?
  end

end
