require 'spec_helper'

describe TrackedDay do
  describe "#sleep_total" do
    before { Timecop.travel "2010-01-03 10pm" }

    subject { child.tracked_days.for_date("2010-01-02").first.sleep_total }

    let(:child) { Factory(:child) }

    context "given a 2 hour nap" do
      before do
        child.sleep_blocks.create(:start_time => "2010-01-02 1pm", :finish_time => "2010-01-02 3pm")
      end

      it { should == 2 * 3600.0 }
    end

    context "given a sleep block that began the day before" do
      before do
        child.sleep_blocks.create(:start_time => "2010-01-01 11pm", :finish_time => "2010-01-02 6am")
      end

      it { should == 6 * 3600.0 }
    end

    context "given a sleep block that ended the day after" do
      before do
        child.sleep_blocks.create(:start_time => "2010-01-02 10pm", :finish_time => "2010-01-03 6am")
      end

      it { should == 2 * 3600.0 }
    end

    context "given a sleep block that began the day before and ended the day after" do
      before do
        child.sleep_blocks.create(:start_time => "2010-01-01 6pm", :finish_time => "2010-01-03 6am")
      end

      it { should == 24 * 3600.0 }
    end
  end
end
