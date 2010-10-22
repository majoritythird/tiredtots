class SleepBlock < ActiveRecord::Base
  belongs_to :child

  validates :start, :presence => true

  scope :unfinished, where(:finish => nil)

end
