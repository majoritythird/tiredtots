class SleepBlock < ActiveRecord::Base
  belongs_to :child

  validates :start, :presence => true

  scope :open, where(:finish => nil)

end
