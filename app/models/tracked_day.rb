class TrackedDay < ActiveRecord::Base
  belongs_to :child

  scope :for_date, lambda { |date|
    where(:for_date => date)
  }

  def recalculate
    self.sleep_total = 0.0
    child.sleep_blocks.covering(for_date).each do |sleep_block|
      if sleep_block.began_before_and_ended_on(for_date)
        self.sleep_total += sleep_block.finish_time - for_date.to_time.beginning_of_day
      elsif sleep_block.began_and_ended_on(for_date)
        self.sleep_total += sleep_block.finish_time - sleep_block.start_time
      elsif sleep_block.began_on_and_ended_after(for_date)
        self.sleep_total += for_date.to_time.end_of_day - sleep_block.start_time
      elsif sleep_block.began_before_and_ended_after(for_date)
        self.sleep_total += (60.0 * 60.0 * 24)
      end
    end
    save!
  end

end
