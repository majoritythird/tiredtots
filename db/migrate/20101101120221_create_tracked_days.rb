class CreateTrackedDays < ActiveRecord::Migration
  def self.up
    create_table :tracked_days do |t|
      t.belongs_to :child
      t.date :for_date
      t.string :segments
      t.float :sleep_total, :default => 0.0
    end
  end

  def self.down
    drop_table :tracked_days
  end
end
