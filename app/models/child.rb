class Child < ActiveRecord::Base

  belongs_to :user
  has_many :sleep_blocks

  validates :name, :presence => true

  def open_sleep_block?
    sleep_blocks.open.any?
  end

end
