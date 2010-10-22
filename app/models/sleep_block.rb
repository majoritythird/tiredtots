class SleepBlock < ActiveRecord::Base
  belongs_to :child

  validates :start, :presence => true

end
