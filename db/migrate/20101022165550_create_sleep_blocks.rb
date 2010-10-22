class CreateSleepBlocks < ActiveRecord::Migration
  def self.up
    create_table :sleep_blocks do |t|
      t.belongs_to :child
      t.datetime :start
      t.datetime :finish
    end
  end

  def self.down
    drop_table :sleep_blocks
  end
end
