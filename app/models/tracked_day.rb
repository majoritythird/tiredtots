class TrackedDay < ActiveRecord::Base
  belongs_to :child

  scope :for_date, lambda { |date|
    where(:for_date => date)
  }

  scope :descending, order('for_date desc')
  scope :paged, lambda { |page, limit| limit(limit).offset(page.to_i*limit.to_i) }
  scope :recent, limit(21)

  def recalculate
    self.sleep_total = 0
    child.sleep_blocks.covering(for_date).each do |sleep_block|
      if sleep_block.began_before_and_ended_on(for_date)
        self.sleep_total += sleep_block.finish_time - Time.zone.beginning_of_day(for_date)
      elsif sleep_block.began_and_ended_on(for_date)
        self.sleep_total += sleep_block.finish_time - sleep_block.start_time
      elsif sleep_block.began_on_and_ended_after(for_date)
        self.sleep_total += (Time.zone.end_of_day(for_date) - sleep_block.start_time).round
      elsif sleep_block.began_before_and_ended_after(for_date)
        self.sleep_total += (60 * 60 * 24)
      end
    end
    save!
  end

  def sleep_total_in_hours
    sleep_total / 3600.0
  end

end
