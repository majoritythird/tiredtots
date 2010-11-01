require 'spec_helper'

describe SleepBlocksHelper do
  describe "#friendly_sleep_total" do
    subject { helper.friendly_sleep_total(seconds) }

    context "returns a friendly string with no precision given an even number of hours" do
      let(:seconds) { 3600.0 }
      it { should == "1 hour"}
    end

    context "returns a friendly string with precision given fractional minutes" do
      let(:seconds) { 22390.0 }
      it { should == "6.2 hours"}
    end

    context "returns an empty string given nil" do
      let(:seconds) { nil }
      it { should == ""}
    end

  end
end
