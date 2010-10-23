class ChangeStartFinishOnSleepBlocks < ActiveRecord::Migration
  def self.up
    rename_column :sleep_blocks, :start, :start_time
    rename_column :sleep_blocks, :finish, :finish_time
  end

  def self.down
    rename_column :sleep_blocks, :finish_time, :finish
    rename_column :sleep_blocks, :start_time, :start
  end
end
