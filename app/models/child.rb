class Child < ActiveRecord::Base

  belongs_to :user
  has_many :sleep_blocks

  validates :name, :presence => true

end
